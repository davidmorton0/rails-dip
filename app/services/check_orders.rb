# frozen_string_literal: true

class CheckOrders
  ORDER_TYPES = %w[MoveOrder HoldOrder SupportHoldOrder SupportMoveOrder].freeze
  PROVINCE_TYPES = %w[Inland Coastal].freeze
  FAIL_REASONS = {
    blocked: 'Blocked',
    not_adjacent: 'Target province not adjacent',
    water_province: 'Army cannot move to Water province',
  }.freeze

  def initialize(turn:)
    @players = Player.where(game: turn.game)
    @orders = turn.orders
  end

  def call
    process_initial_order_failures
    process_initial_order_successes
    check_for_further_blocked_units
    update_remaining_orders_to_success
  end

  private

  attr_reader :orders, :players, :failure_reason

  def process_initial_order_failures
    unresolved_orders(['MoveOrder']).each do |order|
      unit = Unit.find_by(province: order.origin_province, player: players)

      if initial_order_failure?(order: order, unit: unit)
        order.update(success: false, failure_reason: failure_reason)
      end
    end
  end

  def process_initial_order_successes
    unresolved_orders(['MoveOrder']).each do |order|
      if initial_order_success?(order: order)
        order.update(success: true)
      end
    end
  end

  def check_for_further_blocked_units
    blocked_units = true
    while blocked_units
      blocked_units = false
      unresolved_orders(['MoveOrder']).each do |order|
        blocked_units ||= check_blocked_units(order)
      end
    end
  end

  def check_blocked_units(order)
    if blocked_unit_in_target_province?(order: order)
      order.update(success: false, failure_reason: FAIL_REASONS[:blocked])
      return true
    end

    false
  end

  def update_remaining_orders_to_success
    unresolved_orders(ORDER_TYPES).each do |order|
      order.update(success: true)
    end
  end

  def unresolved_orders(types)
    orders.select { |order| order.success.nil? && types.include?(order.type) }
  end

  def initial_order_failure?(order:, unit:)
    return true unless provinces_adjacent?(unit.province, order.target_province)
    return true unless correct_province_type?(unit.unit_type, order.target_province.province_type)
    return true if stationary_unit_in_target_province?(order)
    return true if two_units_exchanging_position?(order)
    return true if two_units_entering_same_province?(order)
  end

  def initial_order_success?(order:)
    return false if Unit.find_by(province: order.target_province, player: players).present?
    return false if orders.count { |ord| ord.target_province == order.target_province } > 1

    true
  end

  def blocked_unit_in_target_province?(order:)
    orders.select { |ord| ord.origin_province == order.target_province && ord.success == false }.any?
  end

  def two_units_entering_same_province?(order)
    return false if orders.count { |ord| ord.target_province == order.target_province } <= 1

    blocked
  end

  def two_units_exchanging_position?(order)
    return false if orders.select do |ord|
                      ord.target_province == order.origin_province && order.target_province == ord.origin_province
                    end.none?

    blocked
  end

  def stationary_unit_in_target_province?(order)
    return false if Unit.find_by(province: order.target_province, player: players).nil?
    return false if orders.select { |ord| ord.origin_province == order.target_province && ord.target_province_id }.any?

    blocked
  end

  def provinces_adjacent?(province1, province2)
    return true if province1.adjacent?(province2)

    fail_with_reason(FAIL_REASONS[:not_adjacent])
  end

  def correct_province_type?(unit_type, province_type)
    return true if unit_type == 'Army' && PROVINCE_TYPES.include?(province_type)

    fail_with_reason(FAIL_REASONS[:water_province])
  end

  def blocked
    @failure_reason = FAIL_REASONS[:blocked]

    true
  end

  def fail_with_reason(reason)
    @failure_reason = reason

    false
  end
end
