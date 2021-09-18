require 'rails_helper'

RSpec.describe Game, type: :model do
  subject { create(:game, **attributes) }

  let(:attributes) { {} }
  let(:player2) { create(:player, country: 'Blue', game: subject) }
  let(:player1) { create(:player, country: 'Red', game: subject) }

  it { is_expected.to belong_to(:variant) }
  it { is_expected.to have_many(:players) }
  it { is_expected.to have_many(:units) }
  it { is_expected.to have_many(:turns) }
  it { is_expected.to delegate_method(:country_list).to(:variant) }

  describe '#next_turn' do
    let(:turn) { create(:turn, game: subject, season: season, year: 1901) }

    before do
      turn
    end

    context 'when it is spring' do
      let(:season) { 'Spring' }

      it 'moves to the next turn' do
        expect { subject.next_turn }
          .to change { subject.current_turn.season }.to('Autumn').and(not_change { subject.current_turn.year })
      end
    end

    context 'when it is winter' do
      let(:season) { 'Winter' }

      it 'moves to the next season' do
        expect { subject.next_turn }
          .to change { subject.current_turn.season }.to('Spring').and(change { subject.current_turn.year }.by(1))
      end
    end
  end

  describe '#countries_with_players' do
    before do
      player1
      player2
    end

    it 'returns the a list of countries with players for the game' do
      expect(subject.countries_with_players).to eq('Red, Blue')
    end
  end

  describe '#total_units' do
    before do
      create(:unit, player: player1)
      create(:unit, player: player2)
      create(:unit, player: player2)
    end

    it 'returns the total units for the game' do
      expect(subject.total_units).to eq(3)
    end
  end

  describe '#map_image' do
    let(:attributes) { { current_map: current_map_file, variant: variant } }
    let(:variant) { create(:variant, map: map) }
    let(:map) { create(:map, name: 'test') }

    context 'when there is no generated map image' do
      let(:current_map_file) { nil }

      it 'returns the blank map location' do
        expect(subject.map_image).to eq('test.png')
      end
    end

    context 'when there is a generated map image' do
      let(:current_map_file) { 'generated-map-id.png' }

      before { expect(File).to receive(:exist?).and_return(true) }

      it 'returns the generated map image location' do
        expect(subject.map_image).to eq('game-maps/generated-map-id.png')
      end
    end

    context 'when the generated map image is missing' do
      let(:current_map_file) { 'generated-map-id' }

      it 'returns the blank map location' do
        expect(subject.map_image).to eq('test.png')
      end
    end
  end
end
