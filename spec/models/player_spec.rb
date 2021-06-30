# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Player, type: :model do
  let(:order_details) do
    { player: player,
      season: 'Autumn',
      year: '1901',
      target_province: target_province,
      current_province: current_province }
  end
  let(:current_province) { create(:province) }
  let(:target_province) { create(:province) }
  let(:player) { create(:player) }

  it { is_expected.to validate_presence_of(:game) }
  it { is_expected.to validate_presence_of(:country) }

  it 'assigns a move order' do
    expect { subject.assign_move_order(order_details) }.to change(MoveOrder, :count).by(1)

    expect(MoveOrder.last).to have_attributes(
      player: player,
      target_province:
      target_province,
      current_province: current_province,
    )
  end
end
