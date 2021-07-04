# frozen_string_literal: true

class LoadMapData
  def initialize(map:)
    @map = map

    create_provinces
    create_province_links
  end

  private

  attr_reader :map

  def provinces_data
    raise('File not found') unless File.exist?(file_location)

    @provinces_data ||= YAML.load_file(file_location)
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

  def file_location
    @file_location ||= File.join(Dir.pwd, "/lib/maps/#{map.name.downcase}.yml")
  end
end
