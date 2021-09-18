# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Map, type: :model do
  it { is_expected.to have_many(:provinces) }
  it { is_expected.to have_many(:variants) }

  it { is_expected.to validate_presence_of(:name) }
end
