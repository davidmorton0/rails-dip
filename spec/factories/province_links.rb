FactoryBot.define do
  factory :province_link do
    province { build(:province) }
    
    after(:build) do |province_link|
      province_link.links_to ||= build_stubbed(:province)
    end
  end
end