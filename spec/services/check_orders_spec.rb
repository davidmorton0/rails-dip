require 'rails_helper'

RSpec.describe CheckOrders do
  subject { described_class.new(**turn_details) }

  let(:turn_details) { { game: 1, season: 'Spring', year: 1901 } }
  let(:province_1) { create(:province) }
  let(:province_2) { create(:province) }
  let(:unit) { create(:unit, province: province_1) }
  let(:order) { create(:order, unit: unit, target_province: province_2, **turn_details) }

  context 'when a move order is given' do
    let(:orders) { [order] }

    context 'when the order is valid' do

      before { create(:province_link, province: province_1, links_to: province_2) }

      it 'changes the order to success' do
        expect do
          subject.call
          order.reload
        end.to change { order.success }.to(true)
      end
    end

    context 'when the target province is not adjacent to the current province' do
      it 'changes the order to failed' do
        expect do
          subject.call
          order.reload
        end.to change { order.success }.to(false)
      end
    end
  end

end
