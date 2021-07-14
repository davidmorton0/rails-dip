# frozen_string_literal: true

RSpec.describe DrawMap::DrawMap do
  subject { described_class.new(game) }

  let(:game) { build(:game) }

  let(:map_file_location) { Rails.root.join('app/assets/images/classic_map.png') }
  let(:army_file_location) { Rails.root.join('app/assets/images/army.png') }
  let(:new_map_location) { Rails.root.join('app/assets/images/game-maps/new_map.png') }

  let(:map_image) { instance_spy(MiniMagick::Image) }

  it 'draws a map' do
    allow(MiniMagick::Image).to receive(:open).with(map_file_location).and_return(map_image)
    subject.call

    expect(map_image).to have_received(:write).with(new_map_location)
  end
end
