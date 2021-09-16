class BuildOrder < Order
  belongs_to :player
  belongs_to :origin_province, class_name: 'Province'

  validates :year, :season, :unit_type, presence: true
end
