class Unit < ApplicationRecord
  belongs_to :province

  def move(target_province)
    self.update(province: target_province)
  end
end
