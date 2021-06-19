FactoryBot.define do
  factory :order do
    order_type { 'Move' }
    target_province { build(:province) }
    unit { build(:unit) }
    year { 1901 }
    season { 'Spring' }
    game { 1 }
  end
end
