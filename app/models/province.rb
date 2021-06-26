# frozen_string_literal: true

class Province < ApplicationRecord
  has_one :province_link
  has_one :province_link, class_name: 'ProvinceLink', foreign_key: :links_to
  belongs_to :map

  validates :name, :abbreviation, presence: true
  validates :province_type, inclusion: { in: %w[Coastal Inland Water] }

  def adjacent?(province)
    ProvinceLink.where(province: self, links_to: province.id).any? ||
      ProvinceLink.where(province: province, links_to: id).any?
  end
end
