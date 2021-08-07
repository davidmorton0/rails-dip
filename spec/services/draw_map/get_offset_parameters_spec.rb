# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DrawMap::GetOffsetParameters do
  subject { described_class.new(unit: unit, unit_image: unit_image, map_image: map_image).call }

  let(:unit) { build(:unit, province: build(:province, x_pos: x_pos, y_pos: y_pos)) }
  let(:x_pos) { 50 }
  let(:y_pos) { 70 }

  let(:unit_image) { OpenStruct.new(width: unit_image_width, height: unit_image_height) }
  let(:unit_image_width) { 20 }
  let(:unit_image_height) { 30 }

  let(:map_image) { OpenStruct.new(width: map_image_width, height: map_image_height) }
  let(:map_image_width) { 300 }
  let(:map_image_height) { 500 }

  it 'returns the correct parameters' do
    expect(subject).to eq(
      {
        x_pos: x_pos,
        y_pos: y_pos,
        unit_image_width: unit_image_width,
        unit_image_height: unit_image_height,
        map_image_width: map_image_width,
        map_image_height: map_image_height,
      },
    )
  end
end
