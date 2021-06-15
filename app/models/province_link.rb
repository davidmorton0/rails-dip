class ProvinceLink < ApplicationRecord
  belongs_to :province

  validates :province, :links_to, presence: :true
end
