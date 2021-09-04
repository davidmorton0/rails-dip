# frozen_string_literal: true

class Game < ApplicationRecord
  SEASONS = %w[Spring Autumn Winter].freeze

  belongs_to :variant
  has_many :players
  has_many :units, through: :player

  validates :season, inclusion: { in: %w[Spring Autumn Winter] }
  validates :year, presence: true

  def move_to_next_season
    self.season = next_season
    self.year += 1 if season == 'Spring'
  end

  def country_list
    variant.countries.join(', ')
  end

  def countries_with_players
    players.map(&:country).join(', ')
  end

  def total_units
    players.sum { |player| player.units.size }
  end

  def map_image
    return current_map_image if current_map && file_exists?

    default_map
  end

  private

  def next_season
    SEASONS[(SEASONS.index(season) + 1) % 3]
  end

  def default_map
    "#{variant.map.name}.png"
  end

  def current_map_image
    "game-maps/#{current_map}"
  end

  def file_exists?
    File.exist?(Rails.root.join('app/assets/images', current_map_image))
  end
end
