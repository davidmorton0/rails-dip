require 'rails_helper'

RSpec.describe Province, type: :model do
  subject { described_class.new(params) }

  let(:params){ { name: 'Munich', abbreviation: 'MUN', supply_center: true } }

  it 'returns the province name' do
    expect(subject.name).to eq 'Munich'
  end

  it 'returns the province abbreviation' do
    expect(subject.abbreviation).to eq 'MUN'
  end

  it 'returns the province abbreviation' do
    expect(subject.supply_center?).to eq true
  end
end
