# frozen_string_literal: true

class GamesController < ApplicationController
  def show
    @game = Game.find(params['id'])
  end

  def update
    @game = Game.find(params['id'])
    DrawMap::DrawMap.new(@game).call

    redirect_to :show
  end
end
