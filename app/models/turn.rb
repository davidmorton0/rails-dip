class Turn < ApplicationRecord
  SEASONS = %w[Spring Autumn Winter].freeze

  belongs_to :game
  has_many :orders

  validates :season, inclusion: { in: %w[Spring Autumn Winter] }
  validates :year, presence: true

  def next_turn
    new_year = year
    new_year += 1 if season == SEASONS.last

    { season: next_season, year: new_year }
  end

  private

  def next_season
    SEASONS[(SEASONS.index(season) + 1) % 3]
  end
end
