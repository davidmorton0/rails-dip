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
      p = Province.new(province)
      raise "Invalid Province #{p.name} reason: #{p.errors.errors}" unless p.valid?

      p.save
    end
  end

end