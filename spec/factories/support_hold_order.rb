# frozen_string_literal: true

FactoryBot.define do
  factory :support_hold_order do
    player { build(:player) }
    origin_province { build(:province) }
    target_province { build(:province) }
    turn { build(:turn) }
    unit { build(:unit) }
  end
end
