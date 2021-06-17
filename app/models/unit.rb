class Unit < ApplicationRecord
  belongs_to :province
  has_many :orders

  def move(target_province)
    self.update(province: target_province)
  end

  def assign_move_order(target_province)
    Order.create(order_type: 'Move', target_province: target_province, unit: self)
  end
end
