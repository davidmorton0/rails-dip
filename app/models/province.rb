class Province < ApplicationRecord
  has_many :province_links

  def adjacent?(province)
    ProvinceLink.where(province: self, links_to: province.id).any? ||
    ProvinceLink.where(province: province, links_to: self.id).any?
  end
end
