# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  it { is_expected.to belong_to(:player) }
  it { is_expected.to belong_to(:origin_province) }

  it { is_expected.to validate_presence_of(:year) }
  it { is_expected.to validate_presence_of(:season) }
end
