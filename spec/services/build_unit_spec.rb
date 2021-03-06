# frozen_string_literal: true

RSpec.describe BuildUnit do
  subject { described_class.new(**params) }

  let(:params) { { province: province, unit_type: unit_type, player: player } }
  let(:province) { create(:province) }
  let(:unit_type) { 'Army' }
  let(:player) { create(:player) }

  it 'builds a unit' do
    expect { subject.call }.to change(Unit, :count).by(1)

    expect(Unit.last).to have_attributes(
      province: province,
      player: player,
      unit_type: unit_type,
    )
  end

  context 'when a unit already exists in the province' do
    before do
      create(:unit, province: province, player: create(:player, game: player.game))
    end

    it 'does not build a unit' do
      expect { subject.call }.not_to change(Unit, :count)
    end
  end
end
