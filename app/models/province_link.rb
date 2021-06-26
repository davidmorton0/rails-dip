# frozen_string_literal: true

class ProvinceLink < ApplicationRecord
  belongs_to :province
  belongs_to :links_to, class_name: 'Province', foreign_key: :links_to

  validates :province, :links_to, presence: true
end
