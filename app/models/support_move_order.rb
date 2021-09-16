class SupportMoveOrder < Order
  belongs_to :target_province, class_name: 'Province'

  validates :unit_type, absence: true
end
