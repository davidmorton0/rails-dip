# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :player
  belongs_to :target_province, class_name: 'Province', foreign_key: :target_province
  belongs_to :current_province, class_name: 'Province', foreign_key: :current_province

  validates :player, :year, :season, presence: true
end
