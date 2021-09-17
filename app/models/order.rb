# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :player
  belongs_to :turn
  belongs_to :origin_province, class_name: 'Province'

  validates :year, :season, presence: true
end
