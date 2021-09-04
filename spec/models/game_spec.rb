require 'rails_helper'

RSpec.describe Game, type: :model do
  let(:game) { build(:game, season: season) }

  it { is_expected.to validate_presence_of(:year) }
  it { is_expected.to validate_inclusion_of(:season).in_array(%w[Spring Autumn Winter]) }

  describe '#move_to_next_season' do
    context 'when it is spring' do
      let(:season) { 'Spring' }

      it 'moves to the next season' do
        expect { game.move_to_next_season }.to change(game, :season).to('Autumn').and(not_change(game, :year))
      end
    end

    context 'when it is winter' do
      let(:season) { 'Winter' }

      it 'moves to the next season' do
        expect { game.move_to_next_season }.to change(game, :season).to('Spring').and(change(game, :year).by(1))
      end
    end
  end

  describe '#country_list' do
    let(:game) { build(:game, variant: build(:variant, countries: %w[Red Blue Yellow])) }

    it 'lists the countries for game' do
      expect(game.country_list).to eq('Red, Blue, Yellow')
    end
  end

  describe '#countries_with_players' do
    let(:game) { build_stubbed(:game, players: [player1, player2]) }
    let(:player1) { build_stubbed(:player, country: 'Red') }
    let(:player2) { build_stubbed(:player, country: 'Blue') }

    it 'returns the total countries with players for the game' do
      expect(game.countries_with_players).to eq('Red, Blue')
    end
  end

  describe '#total_units' do
    let(:game) { build_stubbed(:game, players: [player1, player2]) }
    let(:player1) { build_stubbed(:player, units: [build_stubbed(:unit)]) }
    let(:player2) { build_stubbed(:player, units: [build_stubbed(:unit), build_stubbed(:unit)]) }

    it 'returns the total units for the game' do
      expect(game.total_units).to eq(3)
    end
  end

  describe '#map_image' do
    let(:game) { build_stubbed(:game, current_map: current_map, variant: variant) }
    let(:variant) { build_stubbed(:variant, map: map) }
    let(:map) { build_stubbed(:map, name: 'test') }

    context 'when there is no generated map image' do
      let(:current_map) { nil }

      it 'returns the blank map location' do
        expect(game.map_image).to eq('test.png')
      end
    end

    context 'when there is a generated map image' do
      let(:current_map) { 'generated-map-id.png' }

      before { expect(game).to receive(:file_exists?).and_return(true) }

      it 'returns the generated map image location' do
        expect(game.map_image).to eq('game-maps/generated-map-id.png')
      end
    end

    context 'when the generated map image is missing' do
      let(:current_map) { 'generated-map-id' }

      before { expect(game).to receive(:file_exists?).and_return(false) }

      it 'returns the blank map location' do
        expect(game.map_image).to eq('test.png')
      end
    end
  end
end
