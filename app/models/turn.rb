class Turn < ApplicationRecord
  belongs_to :game
  has_many :orders

  validates :season, inclusion: { in: %w[Spring Autumn Winter] }
  validates :year, presence: true
end
