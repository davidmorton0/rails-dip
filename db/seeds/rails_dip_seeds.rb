# frozen_string_literal: true

class RailsDipSeeds
  def call
    LoadVariant.new(variant_name: 'classic').call
    LoadVariant.new(variant_name: 'simple').call
    
    # Create simple game
    game = create_game('Simple')
    Unit.create(unit_type: 'Army', province: game.variant.map.provinces.first, player: game.players.first)
    Unit.create(unit_type: 'Army', province: game.variant.map.provinces.third, player: game.players.first)
    initialize_orders(game)

    # Create classic game
    game = create_game('Classic')
    Unit.create(unit_type: 'Army', province: game.variant.map.provinces.first, player: game.players.first)
    initialize_orders(game)
  end

  private

  def create_game(game_name)
    variant = Variant.find_by(name: game_name)

    SetupNewGame.new(variant: variant).call
  end

  def initialize_orders(game)
    game.players.each do |player|
      player.units.each do |unit|
        HoldOrder.create(turn: game.current_turn, origin_province: unit.province, player: player)
      end
    end
  end
end
