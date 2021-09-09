# frozen_string_literal: true

class CheckOrders
  def initialize(game:)
    @players = Player.where(game: game)
    @orders = MoveOrder.where(player: players, year: game.year, season: game.season)
  end

  def call
    orders.each do |order|
      unit = Unit.find_by(province: order.current_province)
      success = result(order: order, unit: unit)
      order.update(success: success, fail_reason: @fail_reason)
    end
  end

  private

  attr_reader :orders, :players, :fail_reason

  def result(order:, unit:)
    return false unless target_province_provided?(order)
    return false unless provinces_adjacent?(unit.province, order.target_province)
    return false unless correct_province_type?(unit.unit_type, order.target_province.province_type)

    true
  end

  def target_province_provided?(order)
    return true if order.target_province.present?

    @fail_reason = 'No target province given'
    false
  end

  def provinces_adjacent?(province1, province2)
    return true if province1.adjacent?(province2)

    @fail_reason = 'Target province not adjacent'
    false
  end

  def correct_province_type?(unit_type, province_type)
    return true if unit_type == 'Army' && %w[Inland Coastal].include?(province_type)

    @fail_reason = 'Army cannot move to Water province'
    false
  end
end
