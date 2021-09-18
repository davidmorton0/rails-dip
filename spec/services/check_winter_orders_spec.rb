# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CheckWinterOrders do
  subject do
    described_class.new(turn: turn).call
    build_order.reload
  end

  let(:game) { create(:game) }
  let(:turn) { create(:turn, year: 1902, season: 'Winter', game: game) }
  let(:build_order) { create(:build_order, origin_province: create(:province), player: player, turn: turn) }

  let(:player) { create(:player, game: game, supply: supply) }
  let(:supply) { 2 }

  context 'when a build order is given', :aggregate_failures do
    before do
      build_order
    end

    context 'when the order is valid' do
      it 'changes the order to success' do
        expect { subject }.to change(build_order, :success).to(true)
          .and(not_change(build_order, :failure_reason))

        expect(build_order.failure_reason).to eq(nil)
      end
    end

    context 'when the order is from a different turn' do
      let(:previous_turn) { create(:turn, year: 1901, season: 'Winter', game: game) }
      let(:build_order) {
        create(:build_order, origin_province: create(:province), player: player, turn: previous_turn)
      }

      it 'changes the order to success' do
        expect { subject }.to not_change(build_order, :success)
          .and(not_change(build_order, :failure_reason))

        expect(build_order.failure_reason).to eq(nil)
      end
    end

    context 'when the player does not have enough supply', :aggregate_failures do
      let(:supply) { 1 }

      before { create(:unit, player: player) }

      it 'changes the order to fail' do
        expect { subject }.to change(build_order, :success).to(false)
          .and(change(build_order, :failure_reason).to('Player does not have enough supply to build'))
      end
    end

    context 'when more build orders are given than available supply' do
      let(:supply) { 1 }
      let(:additional_build_order) do
        create(:build_order, origin_province: create(:province), player: player, turn: turn)
      end

      before { additional_build_order }

      it 'changes the order to fail' do
        expect do
          subject
          additional_build_order.reload
        end.to change(build_order, :success).to(false)
          .and(change(build_order, :failure_reason).to('Player has issued too many build orders'))
          .and(change(additional_build_order, :success).to(false))
          .and(change(additional_build_order, :failure_reason).to('Player has issued too many build orders'))
      end
    end

    context 'when the two build orders are given for the same province' do
      let(:additional_build_order) do
        create(:build_order, origin_province: build_order.origin_province, player: player, turn: turn)
      end

      before { additional_build_order }

      it 'changes the first order to success and subsequent orders to fail' do
        expect do
          subject
          additional_build_order.reload
        end.to change(build_order, :success).to(true)
          .and(not_change(build_order, :failure_reason))
          .and(change(additional_build_order, :success).to(false))
          .and(change(additional_build_order, :failure_reason).to('More than one build order for the same province'))
      end
    end
  end
end
