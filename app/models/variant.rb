# frozen_string_literal: true

class Variant < ApplicationRecord
  belongs_to :map
  has_many :games

  validates :name, :countries, :map, :starting_season, :starting_year, presence: true
end
