# frozen_string_literal: true

class Unit < ApplicationRecord
  belongs_to :province
  belongs_to :game

  validates :province, :unit_type, :game, presence: true

  def move(target_province)
    update(province: target_province)
  end

end
