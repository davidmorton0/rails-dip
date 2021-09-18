# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Turn, type: :model do
  subject { described_class.new(year: 1901, season: season) }

  let(:season) { 'Spring' }

  it { is_expected.to belong_to(:game) }
  it { is_expected.to have_many(:orders) }

  it { is_expected.to validate_inclusion_of(:season).in_array(%w[Spring Autumn Winter]) }
  it { is_expected.to validate_presence_of(:year) }

  describe '#next_turn' do
    context 'when it is spring' do
      it 'returns the next turn' do
        expect(subject.next_turn).to eq({ season: 'Autumn', year: 1901 })
      end
    end

    context 'when it is winter' do
      let(:season) { 'Winter' }

      it 'returns the next turn' do
        expect(subject.next_turn).to eq({ season: 'Spring', year: 1902 })
      end
    end
  end
end
