# frozen_string_literal: true

class GamesController < ApplicationController
  def show
    @game = Game.find(params['id'])

    @previous_turn_orders = MoveOrder.where(year: @game.previous_turn_year, season: @game.previous_turn_season)
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
