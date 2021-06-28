# frozen_string_literal: true

FactoryBot.define do
  factory :map do
    name { 'Classic' }
    game { create(:game) }
  end
end
