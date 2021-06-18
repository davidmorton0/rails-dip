class CheckOrders
  def initialize(game:, year:, season:)
    @orders = Order.where(game: game, year: year, season: season)
  end

  def call
    orders.each do |order|
      result = provinces_adjacent?(order.unit.province, order.target_province)
      order.update(success: result)
    end
  end

  private

  attr_reader :orders

  def provinces_adjacent?(province_1, province_2)
    province_1.adjacent?(province_2)
  end
end