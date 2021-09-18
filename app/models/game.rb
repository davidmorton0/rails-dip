# frozen_string_literal: true

class Game < ApplicationRecord
  belongs_to :variant
  has_many :players
  has_many :units, through: :players
  has_many :turns

  delegate :country_list, to: :variant

  def next_turn
    next_turn_parameters = current_turn.next_turn
    Turn.create(game: self, **next_turn_parameters)
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

  def previous_turn
    return if turns.size <= 1

    turns.offset(1).last
  end

  private

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
