
# frozen_string_literal: true

class LoadVariant
  FILE_PATH = '/lib/variants/'

  def initialize(variant_name: 'classic')
    @variant_name = variant_name

    create_variant
  end

  private

  attr_reader :variant_name

  def create_variant
    map = map(variant_data['map'])

    Variant.create(map: map, **variant_data.except('map'))
  end

  def variant_data
    @variant_data ||= YAML.load_file(variant_file_location)
  end

  def variant_file_location
    File.join(Dir.pwd, "#{FILE_PATH}/#{variant_name}.yml")
  end

  def map(map_name)
    Map.create(name: map_name)
  end
  
end