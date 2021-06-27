class Game < ApplicationRecord
  belongs_to :map

  validates :map, :year, presence: true
  validates :season, inclusion: { in: %w[Spring Autumn Winter] }

  def process_turn
    self.season = next_season(season)
    self.year += 1 if season == 'Spring'
  end

  def next_season(current_season)
    seasons = %w[Spring Autumn Winter]
    current = seasons.index(current_season)
    seasons[(current + 1) % 3]
  end
end
