# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CheckOrders do
  subject { described_class.new(turn: turn).call }

  let(:game) { create(:game) }
  let(:player) { create(:player, game: game) }
  let(:province1) { create(:province) }
  let(:province2) { create(:province, abbreviation: 'RUH') }
  let(:unit) { create(:unit, province: province1, player: player) }
  let(:move_order) do
    create(:move_order, origin_province: province1, target_province: province2, player: player, turn: turn)
  end
  let(:turn) { create(:turn, season: 'Spring', year: 1900, game: game) }
  let(:province_link) { create(:province_link, province: province1, links_to: province2) }

  before do
    move_order
    unit
    province_link
  end

  context 'when a succesful move order is given' do
    it 'changes the order to success' do
      expect do
        subject
        move_order.reload
      end.to change(move_order, :success).to(true).and(not_change(move_order, :failure_reason))
    end
  end

  context 'when the target province is not adjacent to the current province' do
    let(:province_link) { nil }

    it 'changes the order to failed' do
      expect do
        subject
        move_order.reload
      end.to change(move_order, :success).to(false)
        .and(change(move_order, :failure_reason).to('Target province not adjacent'))
    end
  end

  context 'when the target province is water and the unit is an Army' do
    before { create(:province_link, province: province1, links_to: province2) }

    let(:unit) { create(:unit, province: province1, unit_type: 'Army', player: player) }
    let(:province2) { create(:province, province_type: 'Water') }

    it 'changes the order to failed' do
      expect do
        subject
        move_order.reload
      end.to change(move_order, :success).to(false)
        .and(change(move_order, :failure_reason).to('Army cannot move to Water province'))
    end
  end

  context 'when there is a stationary unit in the target province' do
    before do
      create(:unit, province: province2, player: player)
      create(:hold_order, origin_province: province2, player: player, turn: turn)
    end

    it 'changes the order to failed' do
      expect do
        subject
        move_order.reload
      end.to change(move_order, :success).to(false).and(change(move_order, :failure_reason).to('Blocked'))
    end
  end

  context 'when two units are exchanging position' do
    before do
      create(:unit, province: province2, player: player)
      create(:move_order, origin_province: province2, target_province: province1, player: player, turn: turn)
    end

    it 'changes the order to failed' do
      expect do
        subject
        move_order.reload
      end.to change(move_order, :success).to(false).and(change(move_order, :failure_reason).to('Blocked'))
    end
  end

  context 'when two units are entering the same province' do
    let(:province3) { create(:province) }

    before do
      create(:unit, province: province3, player: player)
      create(:province_link, province: province2, links_to: province3)
      create(:move_order, origin_province: province3, target_province: province2, player: player, turn: turn)
    end

    it 'changes the order to failed' do
      expect do
        subject
        move_order.reload
      end.to change(move_order, :success).to(false).and(change(move_order, :failure_reason).to('Blocked'))
    end
  end

  context 'when three units are moving in a circle' do
    let(:province3) { create(:province) }

    before do
      create(:unit, province: province3, player: player)
      create(:unit, province: province2, player: player)
      create(:province_link, province: province2, links_to: province3)
      create(:province_link, province: province3, links_to: province1)
      create(:move_order, origin_province: province2, target_province: province3, player: player, turn: turn)
      create(:move_order, origin_province: province3, target_province: province1, player: player, turn: turn)
    end

    it 'changes the order to success' do
      expect do
        subject
        move_order.reload
      end.to change(move_order, :success).to(true).and(not_change(move_order, :failure_reason))
    end
  end

  context 'when units are blocked by other blocked units' do
    let(:province3) { create(:province) }

    before do
      create(:unit, province: province3, player: player)
      create(:unit, province: province2, player: player)
      create(:province_link, province: province2, links_to: province3)
      create(:province_link, province: province3, links_to: province2)
      create(:move_order, origin_province: province2, target_province: province3, player: player, turn: turn)
      create(:move_order, origin_province: province3, target_province: create(:province), player: player, turn: turn)
    end

    it 'changes the order to failed' do
      expect do
        subject
        move_order.reload
      end.to change(move_order, :success).to(false).and(change(move_order, :failure_reason).to('Blocked'))
    end
  end
end
