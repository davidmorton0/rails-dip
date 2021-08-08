# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'games/show.html.erb', type: 'view' do # rubocop:disable RSpec/DescribeClass
  it 'shows the game page' do
    assign(:game, create(:game))

    render

    expect(rendered).to match /Classic/
  end
end
