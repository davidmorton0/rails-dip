require 'rails_helper'

RSpec.describe ProvinceLink, type: :model do

  it { is_expected.to validate_presence_of(:province) }
  it { is_expected.to validate_presence_of(:links_to) }
end
