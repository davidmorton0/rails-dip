# frozen_string_literal: true

FactoryBot.define do
  factory :province_link do
    province { build(:province) }
    links_to { build(:province) }
  end
end
