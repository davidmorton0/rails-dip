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
        next unless validate_duplicate_order(order, player)
        next unless validate_excess_supply(order, player)
        next unless validate_enough_supply_for_orders(order, player)

        order.update(success: true)
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

  def validate_duplicate_order(order, player)
    if duplicate_order?(order, player)
      fail_order(order, 'More than one build order for the same province')
      return false
    end
    true
  end

  def validate_excess_supply(order, player)
    unless excess_supply?(player)
      fail_order(order, 'Player does not have enough supply to build')
      return false
    end
    true
  end

  def validate_enough_supply_for_orders(order, player)
    unless enough_supply_for_orders?(player)
      fail_order(order, 'Player has issued too many build orders')
      return false
    end
    true
  end
end
