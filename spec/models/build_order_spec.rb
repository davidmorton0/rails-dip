# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BuildOrder, type: :model do
  it { is_expected.to validate_presence_of(:year) }
  it { is_expected.to validate_presence_of(:season) }
  it { is_expected.to validate_presence_of(:unit_type) }
  it { is_expected.to belong_to(:province) }
  it { is_expected.to belong_to(:player) }
end
