class Player < ApplicationRecord
  belongs_to :game
  has_many :build_orders
  has_many :move_orders
  has_many :units
  accepts_nested_attributes_for :move_orders

  validates :country, :game, :supply, presence: true

  def assign_move_order(current_province:, target_province:, year:, season:)
    MoveOrder.create(
      player: self,
      current_province: current_province,
      target_province: target_province,
      year: year,
      season: season,
    )
  end

  def assign_build_order(province:, unit_type:, year:, season:)
    BuildOrder.create(
      player: self,
      province: province,
      year: year,
      season: season,
      unit_type: unit_type,
    )
  end

  def move_orders_attributes=(attributes)
    # Process the attributes hash
  end
end
