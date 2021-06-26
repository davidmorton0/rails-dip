FactoryBot.define do
  factory :game do
    map { create(:map) }
    year { 1900 }
    season { 'Spring' }
  end
end
