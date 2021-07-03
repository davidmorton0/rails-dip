FactoryBot.define do
  factory :player do
    game { build(:game) }
    country { 'Russia' }
    supply { 3 }
  end
end
