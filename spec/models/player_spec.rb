require 'rails_helper'

RSpec.describe Player, type: :model do
  it { is_expected.to validate_presence_of(:game) }
  it { is_expected.to validate_presence_of(:country) }

  let(:order_details) { { player: player, season: 'Autumn', year: '1901', target_province: target_province, current_province: current_province } }
  let(:current_province) { create(:province) }
  let(:target_province) { create(:province) }
  let(:player) { create(:player) }

  it 'assigns a move order' do
    expect { subject.assign_move_order(order_details) }.to change(Order, :count).by(1)

    expect(Order.last).to have_attributes(player: player, target_province: target_province, current_province: current_province)
  end
end