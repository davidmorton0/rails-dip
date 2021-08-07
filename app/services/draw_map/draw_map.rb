# frozen_string_literal: true

module DrawMap
  class DrawMap
    include AddUnit

    def initialize(game)
      @game = game
      @map_image = MiniMagick::Image.open(map_file_location)
    end

    def call
      game.players.each do |player|
        player.units.each do |unit|
          @map_image = add_unit(unit.province.x_pos, unit.province.y_pos, 'army')
        end
      end

      map_image.write new_map_location
    end

    private

    attr_reader :game, :map_image

    def map_file_location
      Rails.root.join('app/assets/images/classic_map.png')
    end

    def new_map_location
      Rails.root.join('app/assets/images/game-maps/new_map.png')
    end
  end
end
