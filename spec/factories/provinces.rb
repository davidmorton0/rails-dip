FactoryBot.define do
  factory :province do
    name { 'Munich' }
    abbreviation  { 'MUN' }
    supply_center { true }
    map { build(:map) }
  end
end