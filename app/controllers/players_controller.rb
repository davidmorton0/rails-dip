# frozen_string_literal: true

class PlayersController < ApplicationController
  def show
    @player = Player.find(params['id'])
    @game = @player.game
    @orders = MoveOrder.where(player: @player, year: @game.year, season: @game.season)
      .order(:current_province_id, :id)
    return if @orders.any?

    @orders = @player.units.reduce([]) { |orders, unit| orders << MoveOrder.new(current_province: unit.province) }
  end

  def update
    player = Player.find(player_params[:id])

    move_order_params.each do |order_params|
      if order_params[:id]
        move_order = MoveOrder.find(order_params[:id])

        move_order.update(target_province_id: order_params[:target_province_id])
      else
        create_move_order(player, order_params)
      end
    end
    redirect_to game_player_path([player.game.id, player.id])
  end

  def create_move_order(player, order_params)
    MoveOrder.create(
      target_province_id: order_params[:target_province_id],
      current_province_id: order_params[:current_province_id],
      player: player,
      year: player.game.year,
      season: player.game.season,
    )
  end

  def move_order_params
    order_params = params.fetch(:player).fetch(:move_orders_attributes)
    keys = order_params.keys
    keys.map do |key|
      order_params.fetch(key).permit(:id, :class, :current_province_id, :target_province_id)
    end
  end

  def player_params
    params.permit(:id)
  end
end
