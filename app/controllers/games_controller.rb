# frozen_string_literal: true

class GamesController < ApplicationController
  def show
    @game = Game.find(params['id'])
  end
end
