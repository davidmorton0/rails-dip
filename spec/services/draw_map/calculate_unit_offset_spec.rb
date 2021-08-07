# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DrawMap::CalculateUnitOffset do
  subject { described_class.new(unit: unit, unit_image: unit_image, map_image: map_image).call }

  let(:unit) { create(:unit, province: build(:province, x_pos: x_pos, y_pos: y_pos)) }
  let(:x_pos) { 50 }
  let(:y_pos) { 70 }

  let(:unit_image) { OpenStruct.new(width: unit_image_width, height: unit_image_height) }
  let(:unit_image_width) { 20 }
  let(:unit_image_height) { 30 }

  let(:map_image) { OpenStruct.new(width: map_image_width, height: map_image_height) }
  let(:map_image_width) { 300 }
  let(:map_image_height) { 500 }

  context 'when unit image size is a single pixel' do
    let(:unit_image_width) { 1 }
    let(:unit_image_height) { 1 }

    it 'returns the correct offset' do
      expect(subject).to eq '+50+70'
    end
  end

  context 'when unit image size is 20x30' do
    let(:unit_image_width) { 20 }
    let(:unit_image_height) { 30 }

    it 'returns the correct offset' do
      expect(subject).to eq '+40+55'
    end
  end

  context 'when unit image width is more than double the initial offset' do
    let(:x_pos) { 10 }
    let(:unit_image_width) { 30 }

    it 'returns an x offset if 0' do
      expect(subject).to match(/[+]0[+]\d+/)
    end
  end

  context 'when unit image height is more than double the initial offset' do
    let(:y_pos) { 10 }
    let(:unit_image_height) { 50 }

    it 'returns a y offset of 0' do
      expect(subject).to match(/[+]\d+[+]0/)
    end
  end

  context 'when the x position is less than 0' do
    let(:x_pos) { -10 }

    it 'returns an x offset of 0' do
      expect(subject).to match(/[+]0[+]\d+/)
    end
  end

  context 'when the x position is greater than image width' do
    let(:x_pos) { 400 }

    it 'returns an x offset to position the image at the edge of the image' do
      expect(subject).to match(/[+]280[+]\d+/)
    end
  end

  context 'when the y position is less than 0' do
    let(:y_pos) { -10 }

    it 'returns an y offset of 0' do
      expect(subject).to match(/[+]\d+[+]0/)
    end
  end

  context 'when the y position is greater than image width' do
    let(:y_pos) { 600 }

    it 'returns an y offset to position the image at the bottom of the image' do
      expect(subject).to match(/[+]\d+[+]470/)
    end
  end
end