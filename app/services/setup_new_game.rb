# frozen_string_literal: true

class SetupNewGame
  def initialize(variant:)
    @variant = variant
  end

  def call
    @game = Game.create(
      variant: variant,
      year: variant.starting_year,
      season: variant.starting_season,
    )
    create_players
  end

  private

  attr_reader :variant, :game

  def create_players
    variant.countries.each do |country|
      Player.create(
        game: game,
        country: country,
        supply: 3,
      )
    end
  end
end
