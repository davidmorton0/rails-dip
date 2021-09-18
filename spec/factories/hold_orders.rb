# frozen_string_literal: true

FactoryBot.define do
  factory :hold_order do
    origin_province { build(:province) }
    player { build(:player) }
    turn { build(:turn) }
  end
end
