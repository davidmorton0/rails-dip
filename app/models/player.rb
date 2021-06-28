class Player < ApplicationRecord
  belongs_to :game

  validates :country, :game, presence: true
end
