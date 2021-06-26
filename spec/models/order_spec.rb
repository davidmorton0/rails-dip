# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  subject { described_class.new(order_type: 'Move', target_province: province, unit: unit) }

  let(:province) { build(:province) }
  let(:unit) { build(:unit) }

  it 'exists' do
    subject
  end
end
