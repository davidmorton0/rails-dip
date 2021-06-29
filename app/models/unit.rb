# frozen_string_literal: true

class Unit < ApplicationRecord
  belongs_to :province
  belongs_to :player

  validates :province, :unit_type, :player, presence: true

  def move(target_province)
    update(province: target_province)
  end

end
