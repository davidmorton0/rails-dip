# frozen_string_literal: true

module DrawMap
  class DrawMap
    def initialize(game:)
      @game = game
      @map_image = MiniMagick::Image.open(map_file_location)
    end

    def call
      game.players.each do |player|
        player.units.each do |unit|
          @map_image = add_unit(unit)
        end
      end

      map_location = new_map_location

      map_image.write map_location
      game.update(current_map: file_name)
    end

    private

    attr_reader :game, :map_image

    def add_unit(unit)
      ::DrawMap::AddUnit.new(map_image, unit).call
    end

    def map_file_location
      Rails.root.join("app/assets/images/#{game.variant.name.downcase}.png")
    end

    def new_map_location
      Rails.root.join("app/assets/images/game-maps/#{file_name}")
    end

    def file_name
      "#{uuid}.png"
    end

    def uuid
      @uuid ||= SecureRandom.uuid
    end
  end
end
