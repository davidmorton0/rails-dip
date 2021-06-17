require 'rails_helper'

RSpec.describe Province, type: :model do
  subject { described_class.new(name: 'Munich', abbreviation: 'MUN', supply_center: true) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:abbreviation) }

  it 'returns the province name' do
    expect(subject.name).to eq 'Munich'
  end

  it 'returns the province abbreviation' do
    expect(subject.abbreviation).to eq 'MUN'
  end

  it 'returns the province abbreviation' do
    expect(subject.supply_center?).to eq true
  end

  context 'when there is a province link' do
    let(:province){ create(:province) }

    before { create(:province_link, province: subject, links_to: province) }

    it 'is adjacent to a linked province' do
      expect(subject.adjacent?(province)).to eq true
    end
  end

  context 'when there is no province link' do
    let(:province) { create(:province) }

    it 'is not adjacent to a non-linked province' do
      expect(subject.adjacent?(province)).to eq false
    end
  end

  context 'when there are multiple province links' do
    let(:province_1){ create(:province) }
    let(:province_2){ create(:province) }

    before do
      create(:province_link, province: subject, links_to: province_1)
      create(:province_link, province: province_1, links_to: province_2)
    end

    it 'all the links are correct' do
      expect(subject.adjacent?(province_1)).to eq true
      expect(subject.adjacent?(province_2)).to eq false
      expect(province_1.adjacent?(subject)).to eq true
      expect(province_1.adjacent?(province_2)).to eq true
      expect(province_2.adjacent?(subject)).to eq false
      expect(province_2.adjacent?(province_1)).to eq true
    end
  end
end
