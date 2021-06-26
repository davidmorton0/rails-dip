require 'rails_helper'

RSpec.describe LoadMap do
  subject { described_class.new(map: 'classic') }

  it 'loads a map', :aggregate_failures do
    expect { subject }.to change(Map, :count).by(1)

    expect(Map.first.name).to eq('Classic')
  end

  it 'loads a province', :aggregate_failures do
    expect { subject }.to change(Province, :count).by(75)

    water_provinces = Province.where(province_type: 'Water')
    expect(water_provinces.count).to eq 19
    coastal_provinces = Province.where(province_type: 'Coastal')
    expect(coastal_provinces.count).to eq 42
    inland_provinces = Province.where(province_type: 'Inland')
    expect(inland_provinces.count).to eq 14

    munich = Province.find_by(abbreviation: 'MUN')

    expect(munich).to have_attributes(
      name: 'Munich',
      abbreviation: 'MUN',
      supply_center: true,
      province_type: 'Inland'
    )
  end
end