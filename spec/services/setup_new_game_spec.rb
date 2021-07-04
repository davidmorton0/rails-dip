require 'rails_helper'

RSpec.describe SetupNewGame do
  subject { described_class.new(variant: variant) }

  let(:variant) do
    build(:variant, starting_year: starting_year, starting_season: starting_season, countries: countries)
  end
  let(:starting_year) { 1800 }
  let(:starting_season) { 'Winter' }
  let(:countries) { %w[England Russia Italy] }

  it 'creates a new game' do
    expect { subject.call }.to change(Game, :count).by(1)
    game = Game.last
    
    expect(game).to have_attributes(
      variant: variant,
      year: starting_year,
      season: starting_season,
    )
  end

  it 'creates players' do
    expect { subject.call }.to change(Player, :count).by(3)
    players = Player.all

    expect(players).to include(an_object_having_attributes(country: 'England'),
                               an_object_having_attributes(country: 'Russia'),
                               an_object_having_attributes(country: 'Italy')),
  end
end
