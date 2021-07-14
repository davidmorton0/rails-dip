module DrawMap
  module AddUnit
    def add_unit(x_pos, y_pos, unit_type)
      unit_image = army_image if unit_type

      map_image.composite(unit_image) do |image|
        image.compose 'Over'
        image.geometry "+#{x_pos}+#{y_pos}"
      end
    end

    def army_file_location
      Rails.root.join('app/assets/images/army.png')
    end

    def army_image
      @army_image ||= MiniMagick::Image.open(army_file_location)
    end
  end
end
