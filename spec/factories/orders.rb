# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    order_type { 'Move' }
    current_province { build(:province) }
    target_province { build(:province) }
    year { 1901 }
    season { 'Spring' }
    player { build(:player) }
  end
end
