# frozen_string_literal: true

class Game < ApplicationRecord
  SEASONS = %w[Spring Autumn Winter].freeze

  belongs_to :variant
  has_many :players
  has_many :units, through: :players
  has_many :turns

  def move_to_next_season
    new_year = current_turn.year
    new_year += 1 if current_turn.season == 'Winter'
    Turn.create(game: self, season: next_season, year: new_year)
  end

  def previous_turn_season
    SEASONS[(SEASONS.index(current_turn.season) - 1) % 3]
  end

  def previous_turn_year
    return current_turn.year - 1 if current_turn.season == 'Spring'

    current_turn.year
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

  def current_turn
    turns.last
  end

  private

  def next_season
    SEASONS[(SEASONS.index(current_turn.season) + 1) % 3]
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
