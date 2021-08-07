module DrawMap
  class CalculateUnitOffset

    def initialize(unit:, unit_image:, map_image:)
      @unit = unit
      @unit_image = unit_image
      @map_image = map_image
    end

    def call
      "+#{x_offset}+#{y_offset}"
    end

    private

    attr_reader :unit, :unit_image, :map_image

    def x_offset
      offset(unit.province.x_pos, unit_image.width, map_image.width)
    end

    def y_offset
      offset(unit.province.y_pos, unit_image.height, map_image.height)
    end

    def offset(image_centre, image_dimension, map_dimension)
      offset = image_centre - image_dimension / 2
      return 0 if offset <= 0

      max_offset = map_dimension - image_dimension
      return max_offset if offset > max_offset

      offset
    end
    
  end
end