# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DrawMap::DrawMap do
  subject { described_class.new(game) }

  let(:game) { create(:game) }
  let(:player) { create(:player, game: game) }
  let(:map) { create(:map) }
  let(:unit) { create(:unit, province: build(:province, map: map, x_pos: x_pos, y_pos: y_pos), player: player) }
  let(:x_pos) { 50 }
  let(:y_pos) { 70 }

  let(:map_file_location) { Rails.root.join('app/assets/images/classic_map.png') }
  let(:army_file_location) { Rails.root.join('app/assets/images/army.png') }
  let(:new_map_location) { Rails.root.join('app/assets/images/game-maps/new_map.png') }

  let(:map_image) { instance_spy(MiniMagick::Image) }

  it 'draws a map' do
    allow(MiniMagick::Image).to receive(:open).with(map_file_location).and_return(map_image)
    subject.call

    expect(map_image).to have_received(:write).with(new_map_location)
  end

  it 'draws a map with a unit' do
    unit
    #allow(MiniMagick::Image).to receive(:open).with(map_file_location).and_return(map_image)
    #allow(MiniMagick::Image).to receive(:open).with(army_file_location)
    #image = double(MiniMagick::Tool::Composite)
    #allow(image).to receive(:compose).with('Over')
    #allow(image).to receive(:geometry).with("+#{x_pos}+#{y_pos}")
    #allow(map_image).to receive(:composite).and_yield(image).and_return(map_image)
    subject.call

    #expect(image).to have_received(:compose).with('Over')
    #expect(image).to have_received(:geometry).with("+#{x_pos}+#{y_pos}")
    #expect(map_image).to have_received(:write).with(new_map_location)
  end
end
