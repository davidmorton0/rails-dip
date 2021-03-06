# frozen_string_literal: true

FactoryBot.define do
  factory :province do
    name { 'Munich' }
    abbreviation  { 'MUN' }
    supply_center { true }
    map { build(:map) }
    province_type { 'Inland' }
    x_pos { 20 }
    y_pos { 30 }
  end
end
