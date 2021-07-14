# frozen_string_literal: true

module DrawMap
  class DrawMap
    include AddUnit

    def initialize(game)
      @game = game
      @map_image = MiniMagick::Image.open(map_file_location)
    end

    def call
      units = []
      units.each do |_|
        @map_image = add_unit(20, 20, 'army')
      end

      map_image.write new_map_location
    end

    private

    attr_reader :map_image

    def map_file_location
      Rails.root.join('app/assets/images/classic_map.png')
    end

    def new_map_location
      Rails.root.join('app/assets/images/game-maps/new_map.png')
    end
  end
end
