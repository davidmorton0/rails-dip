# frozen_string_literal: true

class MoveOrder < ApplicationRecord
  belongs_to :player
  belongs_to :target_province, class_name: 'Province', optional: true
  belongs_to :current_province, class_name: 'Province'

  validates :player, :year, :season, presence: true
end
