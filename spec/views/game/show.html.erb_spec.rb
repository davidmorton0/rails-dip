# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'games/show.html.erb', type: 'view' do # rubocop:disable RSpec/DescribeClass
  let(:turn) { create(:turn, game: game) }
  let(:game) { create(:game) }

  before do
    turn
  end

  it 'shows the game page' do
    assign(:game, game)
    assign(:previous_turn_orders, [])

    render

    expect(rendered).to match /Classic/
  end
end
