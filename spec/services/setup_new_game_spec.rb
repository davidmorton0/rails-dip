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

    expect(Game.last).to have_attributes(
      variant: variant,
      year: starting_year,
      season: starting_season,
    )
  end

  it 'creates players' do
    expect { subject.call }.to change(Player, :count).by(3)

    expect(Player.all).to include(an_object_having_attributes(country: 'England'),
                                  an_object_having_attributes(country: 'Russia'),
                                  an_object_having_attributes(country: 'Italy'))
  end
end
