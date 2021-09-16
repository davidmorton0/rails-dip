# frozen_string_literal: true

FactoryBot.define do
  factory :move_order do
    origin_province { build(:province) }
    target_province { build(:province) }
    year { 1901 }
    season { 'Spring' }
    player { build(:player) }
  end
end
