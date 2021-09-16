class HoldOrder < Order
  validates :unit_type, absence: true
end
