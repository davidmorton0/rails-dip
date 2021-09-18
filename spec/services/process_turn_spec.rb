require 'rails_helper'

RSpec.describe ProcessTurn do
  subject { described_class.new(game).call }

  let(:game) { create(:game) }
  let(:turn) { create(:turn, year: 1901, season: 'Spring', game: game) }
  let(:player) { create(:player, game: game) }
  let(:province) { create(:province) }
  let(:move_order) {
    create(:move_order, player: player, origin_province: province, target_province: create(:province), turn: turn)
  }
  let(:unit) { create(:unit, player: player, province: province) }

  before do
    turn
    draw_map = instance_double(DrawMap::DrawMap)
    expect(DrawMap::DrawMap).to receive(:new).with(game).and_return(draw_map)
    expect(draw_map).to receive(:call)
  end

  it 'changes the season' do
    expect do
      subject
    end.to change(game, :current_turn).from(
      an_object_having_attributes(season: 'Spring'),
    )
      .to(an_object_having_attributes(season: 'Autumn'))
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

  it 'creates new orders' do
    unit

    expect { subject }.to change(HoldOrder, :count).from(0).to(1)
  end
end
