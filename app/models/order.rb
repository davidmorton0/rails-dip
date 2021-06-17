class Order < ApplicationRecord
  belongs_to :unit
  belongs_to :target_province, class_name: 'Province', foreign_key: :target_province
end
