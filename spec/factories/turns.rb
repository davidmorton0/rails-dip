# frozen_string_literal: true

FactoryBot.define do
  factory :turn do
    year { 1901 }
    season { 'Spring' }
    game { build(:game) }
  end
end
