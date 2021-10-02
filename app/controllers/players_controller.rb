# frozen_string_literal: true

class PlayersController < ApplicationController
  def show
    @player = Player.find(params['id'])
    @game = @player.game
    @orders = Order.where(turn: @game.current_turn, player: @player).order(:origin_province_id, :id)
  end

  def update
    player = Player.find(player_params[:id])

    move_order_params.each do |order_params|
      move_order = MoveOrder.find(order_params[:id])
      move_order.update(target_province_id: order_params[:target_province_id])
    end

    redirect_to game_player_path([player.game.id, player.id])
  end

  private

  def move_order_params
    order_params = params.fetch(:player).fetch(:move_orders_attributes)
    keys = order_params.keys
    keys.map do |key|
      order_params.fetch(key).permit(:id, :class, :origin_province_id, :target_province_id)
    end
  end

  def player_params
    params.permit(:id)
  end
end
