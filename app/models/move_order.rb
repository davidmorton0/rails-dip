# frozen_string_literal: true

class MoveOrder < Order
  belongs_to :player
  belongs_to :target_province, class_name: 'Province', optional: true
  belongs_to :origin_province, class_name: 'Province'

  validates :player, :year, :season, presence: true

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
