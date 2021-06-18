class Unit < ApplicationRecord
  belongs_to :province
  has_many :orders

  def move(target_province)
    self.update(province: target_province)
  end

  def assign_move_order(target_province, order_details)
    Order.create(
      order_type: 'Move',
      target_province: target_province,
      unit: self,
      game: order_details[:game],
      season: order_details[:season],
      year: order_details[:year]
    )
  end
end
