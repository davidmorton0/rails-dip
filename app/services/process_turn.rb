# frozen_string_literal: true

class ProcessTurn
  def initialize(game)
    @game = game
  end

  def call
    CheckOrders.new(game: game).call
    ProcessOrders.new(game: game).call

    game.move_to_next_season
    DrawMap::DrawMap.new(game).call
  end

  private

  attr_reader :game
end
