# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CheckOrders do
  subject { described_class.new(game: game).call }

  let(:game) { create(:game) }
  let(:player) { create(:player, game: game) }
  let(:province1) { create(:province) }
  let(:province2) { create(:province, abbreviation: 'RUH') }
  let(:unit) { create(:unit, province: province1, player: player) }
  let(:move_order) { create(:move_order, current_province: province1, target_province: province2, **order_details) }
  let(:order_details) { { player: player, season: 'Spring', year: 1900 } }
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
      end.to change(move_order, :success).to(true).and(not_change(move_order, :fail_reason))
    end
  end

  context 'when no target province is provided' do
    let(:province_link) { nil }
    let(:province2) { nil }

    it 'changes the order to failed' do
      expect do
        subject
        move_order.reload
      end.to change(move_order, :success).to(false).and(change(move_order, :fail_reason).to('No target province given'))
    end
  end

  context 'when the target province is not adjacent to the current province' do
    let(:province_link) { nil }

    it 'changes the order to failed' do
      expect do
        subject
        move_order.reload
      end.to change(move_order, :success).to(false)
        .and(change(move_order, :fail_reason).to('Target province not adjacent'))
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
        .and(change(move_order, :fail_reason).to('Army cannot move to Water province'))
    end
  end

  context 'when there is a stationary unit in the target province' do
    before do
      create(:unit, province: province2, player: player)
      create(:move_order, current_province: province2, target_province: nil, **order_details)
    end

    it 'changes the order to failed' do
      expect do
        subject
        move_order.reload
      end.to change(move_order, :success).to(false).and(change(move_order, :fail_reason).to('Blocked'))
    end
  end

  context 'when two units are exchanging position' do
    before do
      create(:unit, province: province2, player: player)
      create(:move_order, current_province: province2, target_province: province1, **order_details)
    end

    it 'changes the order to failed' do
      expect do
        subject
        move_order.reload
      end.to change(move_order, :success).to(false).and(change(move_order, :fail_reason).to('Blocked'))
    end
  end

  context 'when two units are entering the same province' do
    let(:province3) { create(:province) }

    before do
      create(:unit, province: province3, player: player)
      create(:province_link, province: province2, links_to: province3)
      create(:move_order, current_province: province3, target_province: province2, **order_details)
    end

    it 'changes the order to failed' do
      expect do
        subject
        move_order.reload
      end.to change(move_order, :success).to(false).and(change(move_order, :fail_reason).to('Blocked'))
    end
  end

  context 'when three units are moving in a circle' do
    let(:province3) { create(:province) }

    before do
      create(:unit, province: province3, player: player)
      create(:unit, province: province2, player: player)
      create(:province_link, province: province2, links_to: province3)
      create(:province_link, province: province3, links_to: province1)
      create(:move_order, current_province: province2, target_province: province3, **order_details)
      create(:move_order, current_province: province3, target_province: province1, **order_details)
    end

    it 'changes the order to success' do
      expect do
        subject
        move_order.reload
      end.to change(move_order, :success).to(true).and(not_change(move_order, :fail_reason))
    end
  end

  context 'when units are blocked by other blocked units' do
    let(:province3) { create(:province) }

    before do
      create(:unit, province: province3, player: player)
      create(:unit, province: province2, player: player)
      create(:province_link, province: province2, links_to: province3)
      create(:province_link, province: province3, links_to: province2)
      create(:move_order, current_province: province2, target_province: province3, **order_details)
      create(:move_order, current_province: province3, target_province: nil, **order_details)
    end

    it 'changes the order to failed' do
      expect do
        subject
        move_order.reload
      end.to change(move_order, :success).to(false).and(change(move_order, :fail_reason).to('Blocked'))
    end
  end
end
