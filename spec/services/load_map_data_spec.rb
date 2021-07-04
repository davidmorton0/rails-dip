require 'rails_helper'

RSpec.describe LoadMapData do
  subject { described_class.new(map: map) }

  context 'when the classic map is loaded' do
    let(:map) { create(:map, name: 'Classic') }

    it 'creates all the provinces' do
      expect { subject }.to change(Province, :count).by(75)
    end

    it 'creates a province with the correct attributes' do
      subject

      expect(Province.find_by(abbreviation: 'MUN')).to have_attributes(
        name: 'Munich',
        abbreviation: 'MUN',
        supply_center: true,
        province_type: 'Inland',
      )
    end

    it 'creates links between provinces' do
      subject

      province = Province.find_by(abbreviation: 'ADR')
      linked_provinces_abbreviations = %w[TRI ALB ION APU VEN]

      linked_provinces_abbreviations.each do |linked_province|
        expect(province.adjacent?(Province.find_by(abbreviation: linked_province))).to eq true
      end
    end
  end

  context 'when there is no file for the variant specified' do
    let(:map) { create(:map, name: 'Not Map') }

    it 'raises an error' do
      expect { subject }.to raise_error('File not found')
    end
  end
end
