# frozen_string_literal: true

class CheckWinterOrders
  FAIL_REASONS = {
    duplicate: 'More than one build order for the same province',
    no_supply: 'Player does not have enough supply to build',
    not_enough_supply: 'Player has issued too many build orders',
  }.freeze

  def initialize(turn:)
    @game = turn.game
    @players = Player.where(game: game)
    @orders = turn.orders
  end

  def call
    players.each do |player|
      orders.each do |order|
        next unless validate_duplicate_order(order, player)
        next unless validate_excess_supply(order, player)
        next unless validate_enough_supply_for_orders(order, player)

        order.update(success: true)
      end
    end
  end

  private

  attr_reader :players, :game, :orders

  def fail_order(order, reason)
    order.update(success: false, failure_reason: reason)
  end

  def excess_supply?(player)
    player.supply > player.units.count
  end

  def enough_supply_for_orders?(player)
    player.supply >= (player.units.count + orders.count)
  end

  def duplicate_order?(order, _player)
    similar_orders = orders.select { |ord| ord.origin_province == order.origin_province }
    similar_orders.length > 1 && similar_orders.first != order
  end

  def validate_duplicate_order(order, player)
    if duplicate_order?(order, player)
      fail_order(order, FAIL_REASONS[:duplicate])

      return false
    end

    true
  end

  def validate_excess_supply(order, player)
    unless excess_supply?(player)
      fail_order(order, FAIL_REASONS[:no_supply])

      return false
    end

    true
  end

  def validate_enough_supply_for_orders(order, player)
    unless enough_supply_for_orders?(player)
      fail_order(order, FAIL_REASONS[:not_enough_supply])

      return false
    end

    true
  end
end
