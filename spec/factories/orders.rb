FactoryBot.define do
  factory :order do
    order_type { 'Move' }
    target_province { build(:province) }
    unit { build(:unit) }
  end
end
