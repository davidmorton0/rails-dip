require 'rails_helper'

RSpec.describe LoadVariant, :seeds do
  subject { described_class.new(**params).call }

  let(:params) { {} }

  context 'when no variant is specified' do
    it 'loads the default variant', :aggregate_failures do
      expect { subject }.to change(Variant, :count).by(1)

      expect(Variant.last).to have_attributes(
        name: 'Classic',
        map: a_kind_of(Map),
        countries: a_collection_containing_exactly('Austria', 'England', 'France', 'Germany', 'Italy', 'Russia',
                                                   'Turkey'),
        starting_year: 1901,
        starting_season: 'Spring',
      )
    end
  end

  context 'when a map is specified' do
    let(:params) { { variant_name: 'italy_vs_germany' } }

    it 'loads the correct variant', :aggregate_failures do
      expect { subject }.to change(Variant, :count).by(1)

      expect(Variant.last).to have_attributes(
        name: 'Italy vs Germany',
        map: a_kind_of(Map),
        countries: a_collection_containing_exactly('Germany', 'Italy'),
        starting_year: 1901,
        starting_season: 'Spring',
      )
    end
  end

  context 'when there is no file for the variant specified' do
    let(:params) { { variant_name: 'not_a_variant' } }

    it 'raises an error' do
      expect { subject }.to raise_error('File not found')
    end
  end

  context 'when the map already exists' do
    before { create(:map, name: 'classic') }

    it 'does not create a new map' do
      expect { subject }.not_to change(Map, :count)
    end
  end

  context 'when the map does not exist' do
    it 'loads the map data' do
      expect { subject }.to change(Map, :count).by(1).and(change(Province, :count).by(75))
    end
  end
end
