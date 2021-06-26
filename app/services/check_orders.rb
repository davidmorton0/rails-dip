# frozen_string_literal: true

class CheckOrders
  def initialize(game:, year:, season:)
    @orders = Order.where(game: game, year: year, season: season)
  end

  def call
    orders.each do |order|
      result = provinces_adjacent?(order.unit.province, order.target_province) &&
        correct_province_type?(order.unit.unit_type, order.target_province.province_type)
      order.update(success: result, fail_reason: @fail_reasons)
    end
  end

  private

  attr_reader :orders

  def provinces_adjacent?(province1, province2)
    if province1.adjacent?(province2)
      true
    else
      @fail_reasons = 'Target province not adjacent'
      false
    end
  end

  def correct_province_type?(unit_type, province_type)
    return true if unit_type == 'Army' && %w[Inland Coastal].include?(province_type)

    @fail_reasons = 'Army cannot move to Water province'
    false
  end
end
