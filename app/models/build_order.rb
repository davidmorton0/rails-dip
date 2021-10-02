class BuildOrder < Order
  validates :unit_type, presence: true
  validates :unit, absence: true
end
