# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :player
  belongs_to :turn
  belongs_to :unit, optional: true
  belongs_to :origin_province, class_name: 'Province'
end
