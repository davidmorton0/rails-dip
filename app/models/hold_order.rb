class HoldOrder < Order
  validates :unit_type, absence: true
  validates :unit, presence: true
end
