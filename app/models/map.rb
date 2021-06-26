# frozen_string_literal: true

class Map < ApplicationRecord
  has_many :provinces

  validates :name, presence: true
end
