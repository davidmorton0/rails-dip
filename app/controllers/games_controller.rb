# frozen_string_literal: true

class GamesController < ApplicationController
  def show
    @game = Game.find(params['id'])
    @player = @game.players.first
  end

  def update
    @game = Game.find(params['id'])
    DrawMap::DrawMap.new(@game).call

    redirect_to game_path(@game)
  end

  def index
    @games = Game.all
  end
end
