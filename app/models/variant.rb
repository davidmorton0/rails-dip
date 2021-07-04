# frozen_string_literal: true

class Variant < ApplicationRecord
  has_many :games
  belongs_to :map

  validates :name, :countries, :map, :starting_season, :starting_year, presence: true
end
