# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Province, type: :model do
  subject { described_class.new(name: 'Munich', abbreviation: 'MUN', supply_center: true, map: map) }

  let(:map) { build(:map) }

  it { is_expected.to have_one(:province_link) }
  it { is_expected.to belong_to(:map) }

  it { is_expected.to validate_presence_of(:abbreviation) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:x_pos) }
  it { is_expected.to validate_presence_of(:y_pos) }

  it { is_expected.to validate_inclusion_of(:province_type).in_array(%w[Coastal Inland Water]) }

  it 'returns the province name' do
    expect(subject.name).to eq 'Munich'
  end

  it 'returns the province abbreviation' do
    expect(subject.abbreviation).to eq 'MUN'
  end

  it 'returns the supply center' do
    expect(subject.supply_center?).to eq true
  end

  context 'when there is a province link' do
    let(:province) { create(:province) }

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
    let(:province1) { create(:province) }
    let(:province2) { create(:province) }

    before do
      create(:province_link, province: subject, links_to: province1)
      create(:province_link, province: province1, links_to: province2)
    end

    it 'all the links are correct' do
      expect(subject.adjacent?(province1)).to eq true
      expect(subject.adjacent?(province2)).to eq false
      expect(province1.adjacent?(subject)).to eq true
      expect(province1.adjacent?(province2)).to eq true
      expect(province2.adjacent?(subject)).to eq false
      expect(province2.adjacent?(province1)).to eq true
    end
  end

  describe '#adjacent_provinces' do
    let(:province1) { build(:province, map: map) }
    let(:province2) { build(:province, map: map) }

    before do
      map
      create(:province_link, province: subject, links_to: province1)
      create(:province_link, province: province1, links_to: province2)
    end

    it 'shows the adjacent provinces' do
      expect(subject.adjacent_provinces).to eq [province1]
    end
  end
end
