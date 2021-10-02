# frozen_string_literal: true

FactoryBot.define do
  factory :support_move_order do
    origin_province { build(:province) }
    player { build(:player) }
    target_province { build(:province) }
    turn { build(:turn) }
    unit { build(:unit) }
  end
end
