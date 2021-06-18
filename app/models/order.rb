class Order < ApplicationRecord
  belongs_to :unit
  belongs_to :target_province, class_name: 'Province', foreign_key: :target_province

  validates :game, :year, :season, presence: :true
end
