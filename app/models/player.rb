class Player < ApplicationRecord
  belongs_to :game
  has_many :orders
  has_many :units

  validates :country, :game, presence: true

  def assign_move_order(order_details)
    Order.create(
      player: self,
      **order_details,
    )
  end
end
