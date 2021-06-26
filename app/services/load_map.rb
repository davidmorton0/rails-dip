class LoadMap
  def initialize(map: 'classic')
    file = File.join(Dir.pwd, '/lib/maps/classic/map.yml')
    map_data = YAML.load_file(file)
    Map.create(map_data)

    load_province
  end

  def load_province
    file = File.join(Dir.pwd, '/lib/maps/classic/provinces.yml')
    provinces = YAML.load_file(file)
    provinces.each do |province|
      province.merge!(map: Map.first)
      p = Province.new(province.except("linked_to"))
      raise "Invalid Province #{p.name} reason: #{p.errors.errors}" unless p.valid?

      p.save
    end
    provinces.each do |province|
      p = Province.find_by(abbreviation: province["abbreviation"])
      create_province_links(p, province["linked_to"]) if province["linked_to"]
    end
  end

  def create_province_links(province, links)
    links.each do |link|
      ProvinceLink.create(province: province, links_to: Province.find_by(abbreviation: link))
    end
  end
end