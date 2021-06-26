# frozen_string_literal: true

class Unit < ApplicationRecord
  belongs_to :province
  has_many :orders

  def move(target_province)
    update(province: target_province)
  end

  def assign_move_order(target_province, order_details)
    Order.create(
      order_type: 'Move',
      target_province: target_province,
      unit: self,
      **order_details,
    )
  end
end
