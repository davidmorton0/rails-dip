# frozen_string_literal: true

class RailsDipSeeds
  def call
    LoadVariant.new(variant_name: 'classic').call
    LoadVariant.new(variant_name: 'simple').call
    
    # Create simple game
    game = create_game('Simple')
    Unit.create(unit_type: 'Army', province: game.variant.map.provinces.first, player: game.players.first)
    Unit.create(unit_type: 'Army', province: game.variant.map.provinces.third, player: game.players.first)
    initialize_hold_orders(game)

    # Create classic game
    game = create_game('Classic')
    Unit.create(unit_type: 'Army', province: game.variant.map.provinces.first, player: game.players.first)
    Unit.create(unit_type: 'Army', province: game.variant.map.provinces.second, player: game.players.first)
    Unit.create(unit_type: 'Army', province: game.variant.map.provinces.third, player: game.players.first)
    initialize_hold_orders(game)
    provinces = game.variant.map.provinces

    u4 = Unit.create(unit_type: 'Army', province: provinces[4], player: game.players.second)
    u5 = Unit.create(unit_type: 'Army', province: provinces[5], player: game.players.second)
    u6 = Unit.create(unit_type: 'Army', province: provinces[6], player: game.players.second)
    u7 = Unit.create(unit_type: 'Army', province: provinces[7], player: game.players.second)


    m = MoveOrder.create(turn: game.current_turn, origin_province: u4.province, target_province: provinces[5], player: u4.player, unit: u4)
    s = SupportHoldOrder.create(turn: game.current_turn, origin_province: u5.province, target_province: provinces[6], player: u5.player, unit: u5)
    s2 = SupportMoveOrder.create(turn: game.current_turn, origin_province: u6.province, target_province: provinces[7], player: u6.player, unit: u6)
  end

  private

  def create_game(game_name)
    variant = Variant.find_by(name: game_name)

    SetupNewGame.new(variant: variant).call
  end

  def initialize_hold_orders(game)
    game.players.each do |player|
      player.units.each do |unit|
        HoldOrder.create(turn: game.current_turn, origin_province: unit.province, player: player, unit: unit)
      end
    end
  end
end
