# frozen_string_literal: true

class ProcessTurn
  def initialize(game)
    @game = game
  end

  def call
    CheckOrders.new(turn: game.current_turn).call
    ProcessOrders.new(game: game).call

    game.next_turn
    create_new_orders
    DrawMap::DrawMap.new(game).call
  end

  private

  attr_reader :game

  def create_new_orders
    game.players.each do |player|
      player.units.each do |unit|
        HoldOrder.create(origin_province: unit.province,
                         player: player,
                         turn: game.current_turn)
      end
    end
  end
end
