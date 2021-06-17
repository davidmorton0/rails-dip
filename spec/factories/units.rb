FactoryBot.define do
  factory :unit do
    unit_type { 'Army' }
    province { build(:province) }
  end
end