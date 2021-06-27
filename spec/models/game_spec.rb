require 'rails_helper'

RSpec.describe Game, type: :model do
  let(:game) { create(:game, season: season) }

  it { is_expected.to validate_presence_of(:year) }
  it { is_expected.to validate_inclusion_of(:season).in_array(%w[Spring Autumn Winter]) }

  describe '#process_turn' do
    context 'when it is spring' do
      let(:season) { 'Spring' }

      it 'moves to the next season' do
        expect { game.process_turn }.to change(game, :season).to('Autumn').and(not_change(game, :year))
      end
    end

    context 'when it is winter' do
      let(:season) { 'Winter' }

      it 'moves to the next season' do
        expect { game.process_turn }.to change(game, :season).to('Spring').and(change(game, :year).by(1))
      end
    end
  end
end
