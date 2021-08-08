# frozen_string_literal: true

class Game < ApplicationRecord
  belongs_to :variant
  has_many :players
  has_many :units, through: :player

  validates :season, inclusion: { in: %w[Spring Autumn Winter] }
  validates :year, presence: true

  def process_turn
    self.season = next_season(season)
    self.year += 1 if season == 'Spring'
  end

  def next_season(current_season)
    seasons = %w[Spring Autumn Winter]
    current = seasons.index(current_season)
    seasons[(current + 1) % 3]
  end

  def country_list
    variant.countries.join(', ')
  end

  def countries_with_players
    players.map(&:country).join(',')
  end

  def total_units
    players.sum { |player| player.units.count }
  end

  def current_map_image_location
    return "game-maps/#{current_map}" if current_map

    default_map
  end

  def default_map
    'classic_map.png'
  end
end
