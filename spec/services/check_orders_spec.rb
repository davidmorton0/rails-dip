# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CheckOrders do
  subject { described_class.new(**turn_details) }

  let(:turn_details) { { game: game, season: 'Spring', year: 1901 } }
  let(:game) { create(:game) }
  let(:player) { create(:player, game: game) }
  let(:province1) { create(:province) }
  let(:province2) { create(:province, abbreviation: 'RUH') }
  let(:unit) { create(:unit, province: province1) }
  let(:order) { create(:order, current_province: province1, target_province: province2, **order_details) }
  let(:order_details) { { player: player, season: 'Spring', year: 1901 } }

  before do
    order
    unit
  end

  context 'when a move order is given' do
    let(:orders) { [order] }

    context 'when the order is valid' do
      before do
        create(:province_link, province: province1, links_to: province2)
      end

      it 'changes the order to success' do
        expect do
          subject.call
          order.reload
        end.to change(order, :success).to(true)
        expect(order.fail_reason).to eq(nil)
      end
    end

    context 'when the target province is not adjacent to the current province' do
      it 'changes the order to failed' do
        expect do
          subject.call
          order.reload
        end.to change(order, :success).to(false)
          .and(change(order, :fail_reason).to('Target province not adjacent'))
      end
    end

    context 'when the target province is water and the unit is an Army' do
      before { create(:province_link, province: province1, links_to: province2) }

      let(:unit) { create(:unit, province: province1, unit_type: 'Army') }
      let(:province2) { create(:province, province_type: 'Water') }

      it 'changes the order to failed' do
        expect do
          subject.call
          order.reload
        end.to change(order, :success).to(false)
          .and(change(order, :fail_reason).to('Army cannot move to Water province'))
      end
    end
  end
end
