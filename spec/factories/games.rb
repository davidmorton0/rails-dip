# frozen_string_literal: true

FactoryBot.define do
  factory :game do
    variant { build(:variant) }
  end
end
