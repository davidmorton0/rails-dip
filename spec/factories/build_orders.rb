# frozen_string_literal: true

FactoryBot.define do
  factory :build_order do
    origin_province { build(:province) }
    player { build(:player) }
    unit_type { 'Army' }
    turn { build(:turn) }
  end
end
