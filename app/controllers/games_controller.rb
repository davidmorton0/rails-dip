# frozen_string_literal: true

class GamesController < ApplicationController
  def show
    @game = Game.find(params['id'])

    @previous_turn_orders = Order.where(turn: @game.previous_turn)
  end

  def update
    @game = Game.find(params['id'])
    ProcessTurn.new(turn: @game.current_turn).call

    redirect_to game_path(@game)
  end

  def index
    @games = Game.all
  end
end
