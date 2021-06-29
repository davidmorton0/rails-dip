# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Unit, type: :model do
  subject { described_class.new(unit_type: 'Army', province: province) }

  let(:province) { build(:province) }
  let(:target_province) { build(:province) }

  it 'returns the unit type' do
    expect(subject.unit_type).to eq 'Army'
  end

  it 'returns the unit province' do
    expect(subject.province).to eq province
  end

  it 'moves to a province' do
    expect { subject.move(target_province) }.to change(subject, :province)
      .from(province).to(target_province)
  end
end
