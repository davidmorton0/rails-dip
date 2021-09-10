# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Game Players', type: :request, aggregate_failures: true do
  let(:game) { create(:game, season: 'Autumn') }
  let(:player) { create(:player, game: game) }
  let(:move_order) { create(:move_order, year: game.year, season: game.season, player: player, target_province: province_2)}
  let(:province_1) { create(:province, map: game.variant.map, name: 'Province 1') }
  let(:province_2) { create(:province, map: game.variant.map, name: 'Province 2') }
  let(:province_3) { create(:province, map: game.variant.map, name: 'Province 3') }
  let(:province_link) { create(:province_link, province: province_1, links_to: province_3) }
  let(:unit) { create(:unit, province: province_1, player: player) }

  describe 'show page' do
    context 'when there is a game with order' do
      let(:move_order) { create(:move_order, year: game.year, season: game.season, player: player, target_province: province_2)}

      it 'shows a game' do
        unit
        move_order

        get game_player_path(game, player)
        expect(response).to be_successful
        expect(response.body).to include('Game Info')
        expect(response.body).to include('Map Info')
        expect(response.body).to include('Orders')
        expect(response.body).to include(province_1.name)
        expect(response.body).to include(province_2.name)
      end
    end

    context 'when there is a game with no orders' do
      it 'shows a game' do
        unit
        province_2
        province_link

        get game_player_path(game, player)
        expect(response).to be_successful
        expect(response.body).to include('Game Info')
        expect(response.body).to include('Map Info')
        expect(response.body).to include('Orders')
        expect(response.body).to include(province_1.name)
        expect(response.body).not_to include(province_2.name)
      end
    end
  end
end
