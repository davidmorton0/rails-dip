# frozen_string_literal: true

class LoadMap
  attr_reader :map_name, :map, :game, :provinces_data

  def initialize(map: 'classic', game: Game.new)
    @map_name = map
    @game = game

    load_map_data
    load_province_data
    create_provinces
    create_province_links
  end

  def load_map_data
    map_data = YAML.load_file(file_location('map'))

    @map = Map.create(game: game, **map_data)
  end

  def load_province_data
    @provinces_data = YAML.load_file(file_location('provinces'))
  end

  def create_provinces
    provinces_data.each do |province_data|
      create_province(province_data)
    end
  end

  def create_province(province_data)
    province = Province.new(map: map, **province_data.except('linked_to'))
    raise "Invalid Province #{province.name} reason: #{province.errors.errors}" unless province.valid?

    province.save
  end

  def create_province_links
    provinces_data.each do |province_data|
      province = Province.find_by(abbreviation: province_data['abbreviation'])
      create_province_link(province, province_data['linked_to']) if province_data['linked_to']
    end
  end

  def create_province_link(province, links)
    links.each do |link|
      ProvinceLink.create(province: province, links_to: Province.find_by(abbreviation: link))
    end
  end

  def file_location(file)
    File.join(Dir.pwd, "/lib/maps/#{map_name}/#{file}.yml")
  end
end
