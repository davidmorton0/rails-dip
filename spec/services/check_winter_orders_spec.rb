# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CheckWinterOrders do
  subject { described_class.new(game: game) }

  let(:turn) { create(:turn, year: 1902, season: 'Winter', game: game) }
  let(:previous_turn) { create(:turn, year: 1901, season: 'Winter', game: game) }
  let(:build_order) { create(:build_order, origin_province: origin_province, player: player, turn: turn) }
  let(:past_build_order) { create(:build_order, origin_province: origin_province, player: player, turn: previous_turn) }
  let(:origin_province) { create(:province) }
  let(:player) { create(:player, game: game, supply: 1) }
  let(:game) { create(:game) }

  context 'when a build order is given', :aggregate_failures do
    before do
      past_build_order
      build_order
    end

    context 'when the order is valid' do
      it 'changes the order to success' do
        expect do
          subject.call
          build_order.reload
        end.to change(build_order, :success).to(true)
          .and(not_change(past_build_order, :success))

        expect(build_order.failure_reason).to eq(nil)
      end
    end

    context 'when the player does not have enough supply', :aggregate_failures do
      before { create(:unit, player: player) }

      it 'changes the order to fail' do
        expect do
          subject.call
          build_order.reload
        end.to change(build_order, :success).to(false)
          .and(not_change(past_build_order, :success))

        expect(build_order.failure_reason).to eq('Player does not have enough supply to build')
      end
    end

    context 'when more build orders are given than available supply', :aggregate_failures do
      let(:additional_build_order) do
        create(:build_order, origin_province: create(:province), player: player, turn: turn)
      end

      let(:orders) { [build_order, build_order_2] }

      it 'changes the order to fail' do
        expect do
          subject.call
          build_order.reload
          additional_build_order.reload
        end.to change(build_order, :success).to(false)
          .and(change(additional_build_order, :success).to(false))
          .and(not_change(past_build_order, :success))

        expect(build_order.failure_reason).to eq('Player has issued too many build orders')
        expect(additional_build_order.failure_reason).to eq('Player has issued too many build orders')
      end
    end

    context 'when the two build orders are given for the same province', :aggregate_failures do
      let(:additional_build_order) do
        create(:build_order, origin_province: origin_province, player: player, turn: turn)
      end
      let(:player) { create(:player, game: game, supply: 2) }

      it 'changes the first order to success and subsequent orders to fail' do
        expect do
          subject.call
          build_order.reload
          additional_build_order.reload
        end.to change(build_order, :success).to(true)
          .and(change(additional_build_order, :success).to(false))

        expect(additional_build_order.failure_reason).to eq('More than one build order for the same province')
      end
    end
  end
end
