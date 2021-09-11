# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MoveOrder do # , type: :model do
  subject { described_class.new(**attributes) }

  let(:attributes) { {} }

  it { is_expected.to validate_presence_of(:player) }
  it { is_expected.to validate_presence_of(:year) }
  it { is_expected.to validate_presence_of(:season) }

  describe '#description' do
    let(:attributes) { { current_province: current_province, target_province: target_province } }
    let(:current_province) { build(:province) }

    context 'when a target province is provided' do
      let(:target_province) { build(:province) }

      it 'describes the order' do
        expect(subject.description).to eq "Move from #{current_province.name} to #{target_province.name}"
      end
    end

    context 'when no target province is provided' do
      let(:target_province) { nil }

      it 'describes the order' do
        expect(subject.description).to eq 'No target province given'
      end
    end
  end

  describe '#result' do
    let(:attributes) { { success: success, fail_reason: fail_reason } }
    let(:success) { true }
    let(:fail_reason) { nil }

    context 'when the order succeeded' do
      it 'describes the order' do
        expect(subject.result).to eq 'Succeeded'
      end
    end

    context 'when the order failed' do
      let(:success) { false }

      context 'when a fail reason is given' do
        let(:fail_reason) { 'Army cannot move to water' }

        it 'describes the fail reason' do
          expect(subject.result).to eq "Failed - #{fail_reason}"
        end
      end

      context 'when no fail reason is given' do
        let(:fail_reason) { nil }

        it 'describes the fail reason' do
          expect(subject.result).to eq 'Was not processed'
        end
      end
    end
  end
end
