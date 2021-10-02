# frozen_string_literal: true

FactoryBot.define do
  factory :move_order do
    origin_province { build(:province) }
    target_province { build(:province) }
    player { build(:player) }
    turn { build(:turn) }
    unit { build(:unit) }
  end
end
