class Player < ApplicationRecord
  belongs_to :game
  has_many :orders
  has_many :units
  accepts_nested_attributes_for :orders

  validates :country, :game, :supply, presence: true

  def assign_move_order(origin_province:, target_province:, turn:, unit:)
    MoveOrder.create(
      player: self,
      turn: turn,
      origin_province: origin_province,
      target_province: target_province,
      unit: unit,
    )
  end

  def assign_build_order(origin_province:, unit_type:, turn:)
    BuildOrder.create(
      player: self,
      turn: turn,
      origin_province: origin_province,
      unit_type: unit_type,
    )
  end
end
