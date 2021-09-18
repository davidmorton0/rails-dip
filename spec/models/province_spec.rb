# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Province, type: :model do
  let(:map) { build(:map) }
  let(:province1) { create(:province, map: map) }
  let(:province2) { create(:province, map: map) }
  let(:province3) { create(:province, map: map) }
  let(:province_link1) { create(:province_link, province: province1, links_to: province2) }
  let(:province_link2) { create(:province_link, province: province2, links_to: province3) }

  it { is_expected.to have_one(:province_link) }
  it { is_expected.to belong_to(:map) }

  it { is_expected.to validate_presence_of(:abbreviation) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:x_pos) }
  it { is_expected.to validate_presence_of(:y_pos) }

  it { is_expected.to validate_inclusion_of(:province_type).in_array(%w[Coastal Inland Water]) }

  describe '#adjacent?' do
    context 'when there is a province link' do
      before { province_link1 }

      it 'is adjacent to a linked province' do
        expect(province1.adjacent?(province2)).to eq true
      end
    end

    context 'when there is no province link' do
      it 'is not adjacent to a non-linked province' do
        expect(province1.adjacent?(province2)).to eq false
      end
    end

    context 'when there are multiple province links', :aggregate_failures do
      before do
        province_link1
        province_link2
      end

      it 'all the links are correct' do
        expect(province1.adjacent?(province2)).to eq true
        expect(province1.adjacent?(province3)).to eq false
        expect(province2.adjacent?(province1)).to eq true
        expect(province2.adjacent?(province3)).to eq true
        expect(province3.adjacent?(province1)).to eq false
        expect(province3.adjacent?(province2)).to eq true
      end
    end
  end

  describe '#adjacent_provinces' do
    before do
      province_link1
    end

    it 'shows the adjacent provinces' do
      expect(province1.adjacent_provinces).to eq [province2]
    end
  end
end
