# frozen_string_literal: true

class MoveOrder < Order
  belongs_to :target_province, class_name: 'Province'

  validates :unit_type, absence: true
  validates :unit, presence: true

  def description
    if target_province
      "Move from #{origin_province.name} to #{target_province.name}"
    else
      'No target province given'
    end
  end

  def result
    if success
      'Succeeded'
    elsif failure_reason
      "Failed - #{failure_reason}"
    else
      'Was not processed'
    end
  end
end
