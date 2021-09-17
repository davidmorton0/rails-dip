# frozen_string_literal: true

class Game < ApplicationRecord
  SEASONS = %w[Spring Autumn Winter].freeze

  belongs_to :variant
  has_many :players
  has_many :units, through: :players
  has_many :turns

  def move_to_next_season
    new_year = year
    new_year += 1 if season == 'Winter'
    update(season: next_season, year: new_year)
  end

  def previous_turn_season
    SEASONS[(SEASONS.index(season) - 1) % 3]
  end

  def previous_turn_year
    return year - 1 if season == 'Spring'

    year
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
    return default_map unless current_map
    return default_map unless File.exist?(map_file_path)

    current_map_image
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

  def map_file_path
    Rails.root.join('app/assets/images', current_map_image)
  end
end
