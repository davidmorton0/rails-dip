# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Game Players', type: :request, aggregate_failures: true do
  let(:game) { create(:game) }
  let(:turn) { create(:turn, season: 'Autumn', year: 1902, game: game) }
  let(:player) { create(:player, game: game) }

  let(:province1) { create(:province, map: game.variant.map, name: 'Province 1') }
  let(:province2) { create(:province, map: game.variant.map, name: 'Province 2') }
  let(:province3) { create(:province, map: game.variant.map, name: 'Province 3') }
  let(:province_link) { create(:province_link, province: province1, links_to: province2) }

  let(:unit) { create(:unit, province: province1, player: player) }
  let(:move_order) do
    create(:move_order, player: player, origin_province: province1, target_province: province2, turn: turn)
  end

  describe 'show page' do
    before do
      turn
      unit
      province_link
    end

    context 'when there is a game with no orders', :aggregate_failures do
      it 'shows a game' do
        get game_player_path(game, player)
        expect(response).to be_successful
        expect(response.body).to include('Game Info')
        expect(response.body).to include('Map Info')
        expect(response.body).to include('Orders')
        expect(response.body).not_to include(province1.name)
        expect(response.body).not_to include(province2.name)
        expect(response.body).not_to include(province3.name)
      end
    end

    context 'when there is a game with a move order', :aggregate_failures do
      it 'shows the game and order' do
        move_order

        get game_player_path(game, player)
        expect(response).to be_successful
        expect(response.body).to include(province1.name)
        expect(response.body).to include(province2.name)
        expect(response.body).not_to include(province3.name)
      end

      context 'when there is a game with a hold order', :aggregate_failures do
        let(:hold_order) { create(:hold_order, player: player, origin_province: province1, turn: turn) }

        it 'shows the game and order' do
          hold_order

          get game_player_path(game, player)
          expect(response).to be_successful
          expect(response.body).to include(province1.name)
          expect(response.body).not_to include(province2.name)
          expect(response.body).not_to include(province3.name)
        end
      end
    end
  end

  describe 'update orders' do
    let(:params) do
      { 'player' => { 'move_orders_attributes' => {
        '0' => { 'class' => 'MoveOrder',
                 'origin_province_id' => move_order.origin_province_id.to_s,
                 'target_province_id' => province3.id.to_s,
                 'id' => move_order.id.to_s },
      } },
        'commit' => 'Submit Orders',
        'controller' => 'players',
        'action' => 'update',
        'id' => player.id.to_s }
    end

    before do
      move_order

      get game_player_path(game, player)
    end

    it 'updates orders a game', :aggregate_failures do
      expect do
        patch game_player_path(game, player), params: params
        move_order.reload
      end.to change(move_order, :target_province).from(province2).to(province3)

      expect(response).to be_redirect
    end
  end
end
