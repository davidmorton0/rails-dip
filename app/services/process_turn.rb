# frozen_string_literal: true

class ProcessTurn
  def initialize(turn:)
    @turn = turn
    @game = turn.game
  end

  def call
    CheckOrders.new(turn: turn).call
    ProcessOrders.new(turn: turn).call

    game.next_turn
    create_new_orders
    DrawMap::DrawMap.new(game: game).call
  end

  private

  attr_reader :game, :turn

  def create_new_orders
    game.players.each do |player|
      player.units.each do |unit|
        HoldOrder.create(origin_province: unit.province,
                         player: player,
                         turn: turn)
      end
    end
  end
end
