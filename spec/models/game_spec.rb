require 'rails_helper'

RSpec.describe Game, type: :model do
  it { is_expected.to validate_presence_of(:map) }
  it { is_expected.to validate_presence_of(:year) }
  it { is_expected.to validate_inclusion_of(:season).in_array(%w[Spring Autumn Winter]) }
end
