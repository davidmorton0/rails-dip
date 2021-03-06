# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Games', type: :request, aggregate_failures: true do
  let(:game) { create(:game) }
  let(:turn) { create(:turn, year: 1901, season: 'Autumn', game: game) }

  describe 'index page' do
    context 'when there are no games' do
      it 'shows an empty list' do
        get games_path
        expect(response).to be_successful
        expect(response.body).to include('Game List')
        expect(response.body).not_to include(game.variant.name)
      end
    end

    context 'when there is a game' do
      before do
        turn
      end

      it 'shows a game' do
        get games_path
        expect(response).to be_successful
        expect(response.body).to include('Game List')
        expect(response.body).to include(game.variant.name)
      end
    end
  end

  describe 'show game page' do
    before do
      turn
    end

    context 'when there is a game with no previous orders' do
      it 'shows a game' do
        get game_path(game)
        expect(response).to be_successful
        expect(response.body).to include('Game Info')
        expect(response.body).to include(game.variant.name)
        expect(response.body).to include(game.variant.countries.first)
        expect(response.body).to include(game.turns.last.season)
        expect(response.body).to include('Map Info')
        expect(response.body).to include(game.variant.map.provinces.count.to_s)
        expect(response.body).to include('Orders from Previous Turn')
        expect(response.body).not_to include('Failed')
      end
    end

    context 'when there are previous orders' do
      let(:player) { create(:player, game: game) }
      let(:previous_turn) { create(:turn, season: 'Spring', year: 1901, game: game) }
      let(:move_order) do
        create(:move_order, player: player, turn: previous_turn, failure_reason: 'Failed')
      end

      it 'shows a previous order' do
        move_order

        get game_path(game)
        expect(response).to be_successful
        expect(response.body).to include('Failed')
      end
    end

    describe 'update game' do
      it 'processes the turn' do
        game

        process_turn = instance_double(ProcessTurn)
        expect(ProcessTurn).to receive(:new).with(turn: turn).and_return(process_turn)
        expect(process_turn).to receive(:call)

        put game_path(game)
      end
    end
  end
end
