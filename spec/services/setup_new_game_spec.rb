require 'rails_helper'

RSpec.describe SetupNewGame do
  subject { described_class.new(variant: variant) }

  let(:variant) { build(:variant) }

  before {  }

  it 'creates a new game' do
    expect { subject.call }.to change(Game, :count).by(1)
    game = Game.last
    expect(game.players.count).to eq 7
  end
end
