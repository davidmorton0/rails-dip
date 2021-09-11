# frozen_string_literal: true

class MoveOrder < ApplicationRecord
  belongs_to :player
  belongs_to :target_province, class_name: 'Province', optional: true
  belongs_to :current_province, class_name: 'Province'

  validates :player, :year, :season, presence: true

  def description
    if target_province
      "Move from #{current_province.name} to #{target_province.name}"
    else
      'No target province given'
    end
  end

  def result
    if success
      'Succeeded'
    elsif fail_reason
      "Failed - #{fail_reason}"
    else
      'Was not processed'
    end
  end
end
