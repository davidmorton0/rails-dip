require 'rails_helper'

RSpec.describe ProcessOrders do
  subject { described_class.new(game: game).call }

  let(:game) { create(:game, year: 1901, season: 'Spring') }
  let(:player) { create(:player, game: game) }
  let(:move_order) do
    create(:move_order, player: player, current_province: province1, target_province: province2, success: true)
  end
  let(:province1) { create(:province) }
  let(:province2) { create(:province) }
  let(:unit) { create(:unit, player: player, province: province1) }

  it 'moves units where orders have suceeded' do
    move_order

    expect do
      subject
      unit.reload
    end.to change(unit, :province)
  end
end
