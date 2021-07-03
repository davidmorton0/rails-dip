class BuildOrder < ApplicationRecord
  belongs_to :player
  belongs_to :province

  validates :year, :season, :unit_type, presence: true
end
