# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DrawMap::AddUnit do
  subject { described_class.new(map_image, unit).call }

  let(:map_image) { MiniMagick::Image.open('spec/fixtures/images/classic_map.png') }
  let(:unit) { build(:unit) }
  let(:get_offset_parameters) { instance_double(DrawMap::GetOffsetParameters) }
  let(:calculate_unit_offset) { instance_double(DrawMap::CalculateUnitOffset) }
  let(:offset) { '+5+5' }

  it 'adds a unit to a map' do
    expect(DrawMap::GetOffsetParameters).to receive(:new).and_return(get_offset_parameters)
    expect(get_offset_parameters).to receive(:call)
    expect(DrawMap::CalculateUnitOffset).to receive(:new).and_return(calculate_unit_offset)
    expect(calculate_unit_offset).to receive(:call).and_return(offset)

    subject
  end
end
