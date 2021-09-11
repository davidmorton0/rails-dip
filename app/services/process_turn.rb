# frozen_string_literal: true

class ProcessTurn
  def initialize(game)
    @game = game
  end

  def call
    CheckOrders.new(game: game).call
    ProcessOrders.new(game: game).call

    game.move_to_next_season
    create_new_orders
    DrawMap::DrawMap.new(game).call
  end

  private

  attr_reader :game

  def create_new_orders
    game.players.each do |player|
      player.units.each do |unit|
        MoveOrder.create(target_province: nil,
                         current_province: unit.province,
                         player: player,
                         year: game.year,
                         season: game.season)
      end
    end
  end
end
