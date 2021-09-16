class Player < ApplicationRecord
  belongs_to :game
  has_many :orders
  has_many :units
  accepts_nested_attributes_for :orders

  validates :country, :game, :supply, presence: true

  def assign_move_order(origin_province:, target_province:, year:, season:)
    MoveOrder.create(
      player: self,
      origin_province: origin_province,
      target_province: target_province,
      year: year,
      season: season,
    )
  end

  def assign_build_order(origin_province:, unit_type:, year:, season:)
    BuildOrder.create(
      player: self,
      origin_province: origin_province,
      year: year,
      season: season,
      unit_type: unit_type,
    )
  end

  def move_orders_attributes=(attributes)
    # Process the attributes hash
  end
end
