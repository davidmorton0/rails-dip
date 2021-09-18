require 'rails_helper'

RSpec.describe ProcessOrders do
  subject { described_class.new(turn: turn).call }

  let(:game) { create(:game) }
  let(:turn) { create(:turn, year: 1901, season: 'Spring', game: game) }
  let(:player) { create(:player, game: game) }

  let(:province) { create(:province) }
  let(:move_order) do
    create(:move_order, player: player, origin_province: province, target_province: create(:province), success: true,
                        turn: turn)
  end
  let(:unit) { create(:unit, player: player, province: province) }

  it 'moves units where orders have suceeded' do
    move_order

    expect do
      subject
      unit.reload
    end.to change(unit, :province)
  end
end
