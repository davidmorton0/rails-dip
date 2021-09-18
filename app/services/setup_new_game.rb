# frozen_string_literal: true

class SetupNewGame
  def initialize(variant:)
    @variant = variant
  end

  def call
    @game = Game.create(variant: variant)

    create_turn
    create_players

    game
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

  def create_turn
    Turn.create(
      year: variant.starting_year,
      season: variant.starting_season,
      game: game,
    )
  end
end
