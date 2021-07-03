# frozen_string_literal: true

FactoryBot.define do
  factory :variant do
    name { 'Classic' }
    countries { %w[Austria England France Germany Italy Russia Turkey] }
    map { build(:map) }
    starting_season { 'Spring' }
    starting_year { 1901 }
  end
end