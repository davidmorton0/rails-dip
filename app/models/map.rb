# frozen_string_literal: true

class Map < ApplicationRecord
  has_many :provinces
  belongs_to :game

  validates :name, presence: true
end
