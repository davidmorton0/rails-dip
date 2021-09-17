# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Turn, type: :model do
  it { is_expected.to belong_to(:game) }
  it { is_expected.to have_many(:orders) }

  it { is_expected.to validate_inclusion_of(:season).in_array(%w[Spring Autumn Winter]) }
  it { is_expected.to validate_presence_of(:year) }
end
