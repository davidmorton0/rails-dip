require 'database_cleaner'

DatabaseCleaner.clean_with(:truncation)

LoadVariant.new(variant_name: 'simple').call
LoadVariant.new(variant_name: 'classic').call

# Create classic game
game = Game.create(
  year: 1900,
  variant: Variant.find_by(name: 'Classic'),
  season: 'Spring'
)
player = Player.create(
  game: game,
  country: 'England',
  supply: 3
)
Unit.create(
  unit_type: 'Army',
  province_id: 6,
  player: player
)

# Create simple game
game = Game.create(
  year: 1900,
  variant: Variant.find_by(name: 'Simple'),
  season: 'Spring'
)
player = Player.create(
  game: game,
  country: 'Yellow',
  supply: 1
)
Unit.create(
  unit_type: 'Army',
  province_id: 0,
  player: player
)
