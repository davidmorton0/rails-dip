# frozen_string_literal: true

class GamesController < ApplicationController
  def show
    @game = Game.find(params['id'])
    previous_turn = @game.turns.offset(1).last

    @previous_turn_orders = previous_turn ? previous_turn.orders : []
  end

  def update
    @game = Game.find(params['id'])
    ProcessTurn.new(@game).call

    redirect_to game_path(@game)
  end

  def index
    @games = Game.all
  end
end
