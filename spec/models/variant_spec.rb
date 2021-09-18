# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Variant, type: :model do
  subject { described_class.new(countries: %w[Red Blue Yellow]) }

  it { is_expected.to belong_to(:map) }
  it { is_expected.to have_many(:games) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:countries) }
  it { is_expected.to validate_presence_of(:map) }
  it { is_expected.to validate_presence_of(:starting_season) }
  it { is_expected.to validate_presence_of(:starting_year) }

  describe '#country_list' do
    it 'lists the countries for game' do
      expect(subject.country_list).to eq('Red, Blue, Yellow')
    end
  end
end
