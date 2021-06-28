require 'rails_helper'

RSpec.describe Player, type: :model do
  it { is_expected.to validate_presence_of(:game) }
  it { is_expected.to validate_presence_of(:country) }
end