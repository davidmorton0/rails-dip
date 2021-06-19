class CheckOrders
  def initialize(game:, year:, season:)
    @orders = Order.where(game: game, year: year, season: season)
  end

  def call
    orders.each do |order|
      result = provinces_adjacent?(order.unit.province, order.target_province)
      order.update(success: result, fail_reason: @fail_reasons)
    end
  end

  private

  attr_reader :orders

  def provinces_adjacent?(province_1, province_2)
    if province_1.adjacent?(province_2)
      true
    else
      @fail_reasons = 'Target province not adjacent'
      false
    end
  end
end