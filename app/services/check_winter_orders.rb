# frozen_string_literal: true

class CheckWinterOrders
  def initialize(game:)
    @game = game
    @players = Player.where(game: game)
  end

  def call
    players.each do |player|
      @build_orders = BuildOrder.where(player: player, year: game.year)

      build_orders.each do |order|
        if duplicate_order?(order, player)
          fail_order(order, 'More than one build order for the same province')
        elsif !excess_supply?(player)
          fail_order(order, 'Player does not have enough supply to build')
        elsif !enough_supply_for_orders?(player)
          fail_order(order, 'Player has issued too many build orders')
        else
          order.update(success: true)
        end
      end
    end
  end

  private

  attr_reader :players, :game, :build_orders

  def fail_order(order, reason)
    order.update(success: false, fail_reason: reason)
  end

  def excess_supply?(player)
    player.supply > player.units.count
  end

  def enough_supply_for_orders?(player)
    player.supply >= (player.units.count + build_orders.count)
  end

  def duplicate_order?(order, player)
    similar_orders = BuildOrder.where(player: player, year: game.year, province: order.province)
    similar_orders.count > 1 && similar_orders.first != order
  end
end
