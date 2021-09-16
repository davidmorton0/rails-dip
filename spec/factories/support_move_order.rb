# frozen_string_literal: true

FactoryBot.define do
  factory :support_move_order do
    origin_province { build(:province) }
    year { 1901 }
    season { 'Spring' }
    player { build(:player) }
    target_province { build(:province) }
  end
end
