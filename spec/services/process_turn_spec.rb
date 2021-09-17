require 'rails_helper'

RSpec.describe ProcessTurn do
  subject { described_class.new(game).call }

  let(:game) { create(:game, year: 1901, season: 'Spring') }
  let(:player) { create(:player, game: game) }
  let(:province) { create(:province) }
  let(:move_order) {
    create(:move_order, player: player, origin_province: province, target_province: create(:province))
  }
  let(:unit) { create(:unit, player: player, province: province) }

  before do
    draw_map = instance_double(DrawMap::DrawMap)
    expect(DrawMap::DrawMap).to receive(:new).with(game).and_return(draw_map)
    expect(draw_map).to receive(:call)
  end

  it 'changes the turn' do
    expect do
      subject
      game.reload
    end.to change(game, :season).to('Autumn')
  end

  it 'checks a failed order' do
    move_order
    unit

    expect do
      subject
      move_order.reload
    end.to change(move_order, :success)
  end

  it 'processes orders' do
    process_orders = instance_double(ProcessOrders)
    expect(ProcessOrders).to receive(:new).with(game: game).and_return(process_orders)
    expect(process_orders).to receive(:call)

    subject
  end

  xit 'creates new orders' do
    unit

    expect { subject }.to change(HoldOrder, :count).from(0).to(1)
  end
end
