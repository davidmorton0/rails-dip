require 'rails_helper'

RSpec.describe Unit, type: :model do
  subject { described_class.new(params) }

  let(:province) { Province.new(name: 'Munich', abbreviation: 'MUN', supply_center: true) }
  let(:target_province) { Province.new(name: 'Tyrolia', abbreviation: 'TYR', supply_center: false) }
  let(:params) { { unit_type: 'Army', province: province } }

  it 'returns the unit province' do
    expect(subject.province.name).to eq 'Munich'
  end

  it 'moves to a province' do
    expect { subject.move(target_province) }.to change(subject, :province)
  end
end
