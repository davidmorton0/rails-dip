# frozen_string_literal: true

class CheckOrders
  def initialize(game:)
    @game = game
    @players = Player.where(game: game)
    @orders = MoveOrder.where(player: players, year: game.year, season: game.season)
  end

  def call
    process_initial_order_failures
    process_initial_order_successes
    check_for_further_blocked_units
    update_remaining_orders_to_success
  end

  private

  attr_reader :orders, :players, :fail_reason, :game

  def process_initial_order_failures
    orders.each do |order|
      unit = Unit.find_by(province: order.origin_province, player: players)
      if initial_order_failure?(order: order, unit: unit)
        order.update(success: false, failure_reason: @failure_reason)
      end
    end
  end

  def process_initial_order_successes
    orders.where(success: nil).each do |order|
      if initial_order_success?(order: order)
        order.update(success: true)
      end
    end
  end

  def check_for_further_blocked_units
    blocked_units = true
    while blocked_units
      blocked_units = false
      orders_to_check = MoveOrder.where(player: players, year: game.year, season: game.season, success: nil)
      orders_to_check.each do |order|
        blocked_units ||= check_blocked_units(order)
      end
    end
  end

  def check_blocked_units(order)
    if blocked_unit_in_target_province?(order: order)
      order.update(success: false, failure_reason: 'Blocked')
      return true
    end

    false
  end

  def update_remaining_orders_to_success
    successful_orders = MoveOrder.where(player: players, year: game.year, season: game.season, success: nil)
    successful_orders.each do |order|
      order.update(success: true)
    end
  end

  def initial_order_failure?(order:, unit:)
    return true unless target_province_provided?(order)
    return true unless provinces_adjacent?(unit.province, order.target_province)
    return true unless correct_province_type?(unit.unit_type, order.target_province.province_type)
    return true if stationary_unit_in_target_province?(order)
    return true if two_units_exchanging_position?(order)
    return true if two_units_entering_same_province?(order)
  end

  def initial_order_success?(order:)
    return false if Unit.find_by(province: order.target_province, player: players).present?
    return false if orders.where(target_province: order.target_province).length > 1

    true
  end

  def blocked_unit_in_target_province?(order:)
    MoveOrder.where(player: players, origin_province: order.target_province, success: false).any?
  end

  def two_units_entering_same_province?(order)
    return false if MoveOrder.where(target_province: order.target_province).length <= 1

    blocked
  end

  def two_units_exchanging_position?(order)
    return false if MoveOrder.where(target_province: order.origin_province,
                                    origin_province: order.target_province).none?

    blocked
  end

  def stationary_unit_in_target_province?(order)
    return false if Unit.find_by(province: order.target_province, player: players).nil?
    return false if MoveOrder.where(origin_province: order.target_province,
                                    player: players).where.not(target_province: nil).any?

    blocked
  end

  def target_province_provided?(order)
    return true if order.target_province.present?

    fail_with_reason('No target province given')
  end

  def provinces_adjacent?(province1, province2)
    return true if province1.adjacent?(province2)

    fail_with_reason('Target province not adjacent')
  end

  def correct_province_type?(unit_type, province_type)
    return true if unit_type == 'Army' && %w[Inland Coastal].include?(province_type)

    fail_with_reason('Army cannot move to Water province')
  end

  def blocked
    @failure_reason = 'Blocked'
    true
  end

  def fail_with_reason(reason)
    @failure_reason = reason
    false
  end
end
