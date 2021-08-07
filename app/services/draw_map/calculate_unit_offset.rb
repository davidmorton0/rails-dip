module DrawMap
  class CalculateUnitOffset
    def initialize(params)
      @params = params
    end

    def call
      "+#{x_offset}+#{y_offset}"
    end

    private

    attr_reader :params

    def x_offset
      offset(params[:x_pos], params[:unit_image_width], params[:map_image_width])
    end

    def y_offset
      offset(params[:y_pos], params[:unit_image_height], params[:map_image_height])
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
