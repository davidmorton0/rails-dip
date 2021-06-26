class Game < ApplicationRecord
  belongs_to :map

  validates :map, :year, presence: true
  validates :season, inclusion: { in: %w[Spring Autumn Winter] }
end
