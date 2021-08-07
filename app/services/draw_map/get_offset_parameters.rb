module DrawMap
  class GetOffsetParameters
    def initialize(unit:, unit_image:, map_image:)
      @unit = unit
      @unit_image = unit_image
      @map_image = map_image
    end

    def call
      {
        x_pos: unit_x,
        y_pos: unit_y,
        unit_image_width: unit_image_width,
        unit_image_height: unit_image_height,
        map_image_width: map_image_width,
        map_image_height: map_image_height,
      }
    end

    private

    attr_reader :unit, :unit_image, :map_image

    def unit_x
      unit.province.x_pos
    end

    def unit_y
      unit.province.y_pos
    end

    def unit_image_width
      unit_image.width
    end

    def unit_image_height
      unit_image.height
    end

    def map_image_width
      map_image.width
    end

    def map_image_height
      map_image.height
    end
  end
end
