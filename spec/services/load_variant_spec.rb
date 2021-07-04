require 'rails_helper'

RSpec.describe LoadVariant do
  subject { described_class.new(**params) }

  context 'when no variant is specified' do
    let(:params) { {} }

    it 'loads a variant', :aggregate_failures do
      expect { subject }.to change(Variant, :count).by(1)

      expect(Variant.last).to have_attributes(
        name: 'Classic',
        map: a_kind_of(Map),
        countries: a_collection_containing_exactly('Austria', 'England', 'France', 'Germany', 'Italy', 'Russia', 'Turkey'),
        starting_year: 1901,
        starting_season: 'Spring'
      )
    end
  end

  context 'when a map is specified' do
    let(:params) { { variant_name: 'italy_vs_germany'} }

    it 'loads the correct variant', :aggregate_failures do
      expect { subject }.to change(Variant, :count).by(1)

      expect(Variant.last).to have_attributes(
        name: 'Italy vs Germany',
        map: a_kind_of(Map),
        countries: a_collection_containing_exactly('Germany', 'Italy'),
        starting_year: 1901,
        starting_season: 'Spring'
      )
    end
  end
end