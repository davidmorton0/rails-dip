require 'rails_helper'

RSpec.describe LoadMap do
  subject { described_class.new(**params) }

  let(:params) { {} }

  context 'when no map is specified' do
    it 'loads the default map', :aggregate_failures do
      expect { subject }.to change(Map, :count).by(1)

      expect(Map.first.name).to eq('Classic')
    end
  end

  context 'when the classic map is loaded' do
    let(:params) { { map: 'classic' } }

    it 'creates all the provinces' do
      expect { subject }.to change(Province, :count).by(75)
    end

    it 'creates a provinces with the correct attributes' do
      subject

      expect(Province.find_by(abbreviation: 'MUN')).to have_attributes(
        name: 'Munich',
        abbreviation: 'MUN',
        supply_center: true,
        province_type: 'Inland'
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
end