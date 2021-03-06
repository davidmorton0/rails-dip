# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Player, type: :model do
  subject { described_class.new(country: 'Turkey', game: game, supply: 3) }

  let(:turn) { create(:turn, season: 'Autumn', year: '1901', game: game) }
  let(:origin_province) { create(:province) }
  let(:target_province) { create(:province) }
  let(:game) { build(:game) }
  let(:player) { create(:player) }

  it { is_expected.to belong_to(:game) }
  it { is_expected.to have_many(:orders) }
  it { is_expected.to have_many(:units) }

  it { is_expected.to accept_nested_attributes_for(:orders) }

  it { is_expected.to validate_presence_of(:game) }
  it { is_expected.to validate_presence_of(:country) }
  it { is_expected.to validate_presence_of(:supply) }

  describe '#assign_move_order' do
    let(:order_details) do
      { turn: turn,
        origin_province: origin_province,
        target_province: target_province }
    end

    it 'creates a move order' do
      expect { subject.assign_move_order(**order_details) }.to change(MoveOrder, :count).by(1)

      expect(MoveOrder.last).to have_attributes(
        player: subject,
        turn: turn,
        origin_province: origin_province,
        target_province: target_province,
      )
    end
  end

  describe '#assign_build_order' do
    let(:order_details) do
      { turn: turn,
        origin_province: origin_province,
        unit_type: 'Army' }
    end

    it 'creates a build order' do
      expect { subject.assign_build_order(**order_details) }.to change(BuildOrder, :count).by(1)

      expect(BuildOrder.last).to have_attributes(
        player: subject,
        turn: turn,
        origin_province: origin_province,
        unit_type: 'Army',
      )
    end
  end
end
