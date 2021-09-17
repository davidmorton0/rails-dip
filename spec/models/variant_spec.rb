# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Variant, type: :model do
  it { is_expected.to belong_to(:map) }
  it { is_expected.to have_many(:games) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:map) }
  it { is_expected.to validate_presence_of(:countries) }
  it { is_expected.to validate_presence_of(:starting_season) }
  it { is_expected.to validate_presence_of(:starting_year) }
end
