require 'rails_helper'

RSpec.describe SetupNewGame do
  subject { described_class.new(variant: variant).call }

  let(:variant) do
    build(:variant, starting_year: starting_year, starting_season: starting_season, countries: %w[England Russia Italy])
  end
  let(:starting_year) { 1800 }
  let(:starting_season) { 'Winter' }

  it 'creates a new game', :aggregate_failures do
    expect { subject }.to change(Game, :count).by(1)
      .and(change(Turn, :count).by(1))

    game = Game.first
    expect(game).to have_attributes(variant: variant)
    expect(game.current_turn).to have_attributes(year: starting_year, season: starting_season, game: game)
  end

  it 'creates players' do
    expect { subject }.to change(Player, :count).by(3)

    expect(Player.all).to include(an_object_having_attributes(country: 'England'),
                                  an_object_having_attributes(country: 'Russia'),
                                  an_object_having_attributes(country: 'Italy'))
  end
end
