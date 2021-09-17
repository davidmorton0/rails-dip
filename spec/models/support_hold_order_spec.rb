# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SupportHoldOrder, type: :model do
  it { is_expected.to belong_to(:target_province).class_name('Province') }

  it { is_expected.to validate_absence_of(:unit_type) }
end
