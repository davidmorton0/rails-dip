# frozen_string_literal: true

class Province < ApplicationRecord
  has_one :province_link
  has_one :province_link, class_name: 'ProvinceLink', foreign_key: :links_to
  belongs_to :map

  validates :name, :abbreviation, :x_pos, :y_pos, presence: true
  validates :province_type, inclusion: { in: %w[Coastal Inland Water] }

  def adjacent?(province)
    ProvinceLink.where(province: self, links_to: province.id).any? ||
      ProvinceLink.where(province: province, links_to: id).any?
  end

  def adjacent_provinces
    map.provinces.select { |province| adjacent?(province) }
  end
end
