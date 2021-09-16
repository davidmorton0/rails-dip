# frozen_string_literal: true

FactoryBot.define do
  factory :build_order do
    origin_province { build(:province) }
    year { 1901 }
    season { 'Spring' }
    player { build(:player) }
    unit_type { 'Army' }
  end
end
