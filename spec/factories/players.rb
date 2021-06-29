FactoryBot.define do
  factory :player do
    game { build(:game) }
    country { 'Russia' }
  end
end
