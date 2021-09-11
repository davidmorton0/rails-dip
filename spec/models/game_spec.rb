require 'rails_helper'

RSpec.describe Game, type: :model do
  subject { build(:game, **attributes) }

  let(:attributes) { {} }

  it { is_expected.to validate_presence_of(:year) }
  it { is_expected.to validate_inclusion_of(:season).in_array(%w[Spring Autumn Winter]) }

  describe '#move_to_next_season' do
    let(:attributes) { { season: season } }

    context 'when it is spring' do
      let(:season) { 'Spring' }

      it 'moves to the next season' do
        expect { subject.move_to_next_season }.to change(subject, :season).to('Autumn').and(not_change(subject, :year))
      end
    end

    context 'when it is winter' do
      let(:season) { 'Winter' }

      it 'moves to the next season' do
        expect {
          subject.move_to_next_season
        }.to change(subject, :season).to('Spring').and(change(subject, :year).by(1))
      end
    end
  end

  describe '#country_list' do
    let(:attributes) { { variant: build(:variant, countries: %w[Red Blue Yellow]) } }

    it 'lists the countries for game' do
      expect(subject.country_list).to eq('Red, Blue, Yellow')
    end
  end

  describe '#countries_with_players' do
    let(:attributes) { { players: [player1, player2] } }
    let(:player1) { build_stubbed(:player, country: 'Red') }
    let(:player2) { build_stubbed(:player, country: 'Blue') }

    it 'returns the total countries with players for the game' do
      expect(subject.countries_with_players).to eq('Red, Blue')
    end
  end

  describe '#total_units' do
    let(:attributes) { { players: [player1, player2] } }
    let(:player1) { build_stubbed(:player, units: [build_stubbed(:unit)]) }
    let(:player2) { build_stubbed(:player, units: [build_stubbed(:unit), build_stubbed(:unit)]) }

    it 'returns the total units for the game' do
      expect(subject.total_units).to eq(3)
    end
  end

  describe '#map_image' do
    let(:attributes) { { current_map: current_map, variant: variant } }
    let(:variant) { build_stubbed(:variant, map: map) }
    let(:map) { build_stubbed(:map, name: 'test') }

    context 'when there is no generated map image' do
      let(:current_map) { nil }

      it 'returns the blank map location' do
        expect(subject.map_image).to eq('test.png')
      end
    end

    context 'when there is a generated map image' do
      let(:current_map) { 'generated-map-id.png' }

      before { expect(File).to receive(:exist?).and_return(true) }

      it 'returns the generated map image location' do
        expect(subject.map_image).to eq('game-maps/generated-map-id.png')
      end
    end

    context 'when the generated map image is missing' do
      let(:current_map) { 'generated-map-id' }

      it 'returns the blank map location' do
        expect(subject.map_image).to eq('test.png')
      end
    end
  end
end
