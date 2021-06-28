# frozen_string_literal: true

class Unit < ApplicationRecord
  belongs_to :province

  def move(target_province)
    update(province: target_province)
  end

end
