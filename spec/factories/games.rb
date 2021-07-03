# frozen_string_literal: true

FactoryBot.define do
  factory :game do
    year { 1900 }
    variant { build(:variant) }
    season { 'Spring' }
  end
end
