# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DrawMap::DrawMap do
  subject { described_class.new(game).call }

  let(:game) { create(:game) }
  let(:unit) { create(:unit, province: build(:province), player: create(:player, game: game)) }

  let(:map_file_location) { Rails.root.join('app/assets/images/classic_map.png') }
  let(:army_file_location) { Rails.root.join('app/assets/images/army.png') }
  let(:new_map_location) { Rails.root.join('app/assets/images/game-maps/new_map.png') }

  let(:map_image) { instance_spy(MiniMagick::Image) }
  let(:unit_image) { instance_spy(MiniMagick::Image) }

  context 'when the map has no units' do
    it 'draws a map' do
      expect(MiniMagick::Image).to receive(:open).with(map_file_location).and_return(map_image)
      subject

      expect(map_image).to have_received(:write).with(new_map_location)
    end
  end

  context 'when the map has a unit' do
    before { unit }

    it 'draws a map with a unit' do
      expect(MiniMagick::Image).to receive(:open).with(map_file_location).and_return(map_image)
      expect(MiniMagick::Image).to receive(:open).with(army_file_location).and_return(unit_image)
      expect(map_image).to receive(:write).with(new_map_location)
      subject
    end
  end
end
