# frozen_string_literal: true

class Province < ApplicationRecord
  has_and_belongs_to_many :links, class_name: 'Province', join_table: :province_links,
                                  association_foreign_key: :links_to
  belongs_to :map

  validates :name, :abbreviation, :x_pos, :y_pos, presence: true
  validates :province_type, inclusion: { in: %w[Coastal Inland Water] }

  def adjacent?(province)
    links.include?(province)
  end

  def adjacent_provinces
    links
  end
end
