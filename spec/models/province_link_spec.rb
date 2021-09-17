# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProvinceLink, type: :model do
  it { is_expected.to belong_to(:province) }
  it { is_expected.to belong_to(:links_to).class_name('Province') }

  it { is_expected.to validate_presence_of(:province) }
  it { is_expected.to validate_presence_of(:links_to) }
end
