# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Player, type: :model do
  subject { described_class.new(country: 'Turkey', game: build(:game)) }

  let(:current_province) { create(:province) }
  let(:target_province) { create(:province) }
  let(:player) { create(:player) }

  it { is_expected.to validate_presence_of(:game) }
  it { is_expected.to validate_presence_of(:country) }

  context 'when a move order is assigned' do
    let(:order_details) do
      { season: 'Autumn',
        year: '1901',
        target_province: target_province,
        current_province: current_province }
    end
    it 'assigns a move order' do
      expect { subject.assign_move_order(**order_details) }.to change(MoveOrder, :count).by(1)

      expect(MoveOrder.last).to have_attributes(
        player: subject,
        target_province: target_province,
        current_province: current_province,
        season: 'Autumn',
        year: 1901,
      )
    end
  end

  context 'when a build order is assigned' do
    let(:order_details) do
      { unit_type: 'Army',
        season: 'Autumn',
        year: '1901',
        province: current_province }
    end
    it 'assigns a build order' do
      expect { subject.assign_build_order(**order_details) }.to change(BuildOrder, :count).by(1)

      expect(BuildOrder.last).to have_attributes(
        player: subject,
        unit_type: 'Army',
        season: 'Autumn',
        year: 1901,
        province: current_province,
      )
    end
  end
end
