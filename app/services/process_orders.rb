# frozen_string_literal: true

class ProcessOrders
  def initialize(turn:)
    @turn = turn
    @orders = MoveOrder.where(turn: turn, success: true)
  end

  def call
    orders.each do |order|
      unit = Unit.where(player: turn.game.players, province: order.origin_province).first
      unit.province = order.target_province
      unit.save
    end
  end

  private

  attr_reader :orders, :turn
end
