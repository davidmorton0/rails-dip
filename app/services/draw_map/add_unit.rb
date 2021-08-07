module DrawMap
  class AddUnit
    ARMY_IMAGE_LOCATION = 'app/assets/images/army.png'.freeze

    def initialize(map_image, unit)
      @map_image = map_image
      @unit = unit
    end

    def call
      map_image.composite(unit_image) do |image|
        image.compose 'Over'
        image.geometry offset
      end
    end

    private

    attr_reader :map_image, :unit

    def army_image
      @army_image ||= MiniMagick::Image.open(army_image_file)
    end

    def army_image_file
      Rails.root.join(ARMY_IMAGE_LOCATION)
    end

    def unit_image
      @unit_image ||= army_image if unit.unit_type == 'Army'
    end

    def offset_params
      @offset_params ||= GetOffsetParameters.new(unit: unit, unit_image: unit_image, map_image: map_image).call
    end

    def offset
      CalculateUnitOffset.new(offset_params).call
    end
  end
end
