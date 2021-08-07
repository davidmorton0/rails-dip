# frozen_string_literal: true

class LoadVariant
  FILE_PATH = '/lib/variants/'

  def initialize(variant_name: 'classic')
    @variant_name = variant_name
  end

  def call
    create_variant
  end

  private

  attr_reader :variant_name

  def create_variant
    map = map(variant_data['map'])

    Variant.create(map: map, **variant_data.except('map'))
  end

  def variant_data
    raise('File not found') unless File.exist?(file)

    @variant_data ||= YAML.load_file(file)
  end

  def file
    @file ||= File.join(Dir.pwd, "#{FILE_PATH}#{variant_name}.yml")
  end

  def map(map_name)
    Map.where(name: map_name).first || create_map(map_name)
  end

  def create_map(map_name)
    map = Map.create(name: map_name)
    LoadMapData.new(map: map).call
    map
  end
end
