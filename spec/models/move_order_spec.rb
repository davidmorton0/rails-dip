# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MoveOrder do # , type: :model do
  subject { described_class.new(**attributes) }

  let(:attributes) { {} }

  it { is_expected.to belong_to(:target_province) }

  describe '#description' do
    let(:attributes) { { origin_province: origin_province, target_province: target_province } }
    let(:origin_province) { build(:province) }

    context 'when a target province is provided' do
      let(:target_province) { build(:province) }

      it 'describes the order' do
        expect(subject.description).to eq "Move from #{origin_province.name} to #{target_province.name}"
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
    let(:attributes) { { success: success, failure_reason: failure_reason } }
    let(:success) { true }
    let(:failure_reason) { nil }

    context 'when the order succeeded' do
      it 'describes the order' do
        expect(subject.result).to eq 'Succeeded'
      end
    end

    context 'when the order failed' do
      let(:success) { false }

      context 'when a fail reason is given' do
        let(:failure_reason) { 'Army cannot move to water' }

        it 'describes the fail reason' do
          expect(subject.result).to eq "Failed - #{failure_reason}"
        end
      end

      context 'when no fail reason is given' do
        let(:failure_reason) { nil }

        it 'describes the fail reason' do
          expect(subject.result).to eq 'Was not processed'
        end
      end
    end
  end
end
