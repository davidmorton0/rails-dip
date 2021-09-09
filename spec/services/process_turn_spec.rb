require 'rails_helper'

RSpec.describe ProcessTurn do
  subject { described_class.new(game).call }

  let(:game) { create(:game, year: 1901, season: 'Spring') }
  let(:player) { create(:player, game: game) }
  let(:move_order) { create(:move_order, player: player, target_province: nil) }

  it 'changes the turn' do
    expect do
      subject
      game.reload
    end.to change(game, :season).to('Autumn')
  end

  it 'checks a failed order' do
    move_order

    expect do
      subject
      move_order.reload
    end.to change(move_order, :success)
  end

  it 'processes orders' do
    process_orders = instance_double(ProcessOrders)
    expect(ProcessOrders).to receive(:new).and_return(process_orders)
    expect(process_orders).to receive(:call)

    subject
  end
end
