# frozen_string_literal: true

class Map < ApplicationRecord
  has_many :provinces
  has_many :variants

  validates :name, presence: true
end
