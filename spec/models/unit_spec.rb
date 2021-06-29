# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Unit, type: :model do
  subject { described_class.new(unit_type: 'Army', province: province) }

  let(:province) { build(:province) }
  let(:target_province) { build(:province) }

  it { is_expected.to validate_presence_of(:province) }
  it { is_expected.to validate_presence_of(:unit_type) }
  it { is_expected.to validate_presence_of(:game) }

  it 'moves to a province' do
    expect { subject.move(target_province) }.to change(subject, :province)
      .from(province).to(target_province)
  end
end
