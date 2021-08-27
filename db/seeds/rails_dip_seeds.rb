# frozen_string_literal: true

class RailsDipSeeds
  def self.call
    LoadVariant.new(variant_name: 'simple').call
    LoadVariant.new(variant_name: 'classic').call

    # Create classic game
    game = Game.create(year: 1900, variant: Variant.find_by(name: 'Classic'), season: 'Spring')
    player = Player.create(game: game, country: 'England', supply: 3)
    Unit.create(unit_type: 'Army', province: Province.fifth, player: player)

    # Create simple game
    game = Game.create(year: 1900, variant: Variant.find_by(name: 'Simple'), season: 'Spring')
    player = Player.create(game: game, country: 'Yellow', supply: 1)
    Unit.create(unit_type: 'Army', province: Province.third, player: player)
    Unit.create(unit_type: 'Army', province: Province.fourth, player: player)
  end
end