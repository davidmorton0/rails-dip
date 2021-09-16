# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HoldOrder, type: :model do
  it { is_expected.to validate_absence_of(:unit_type) }
end
