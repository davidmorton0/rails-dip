# frozen_string_literal: true

class DestroyUnit
  def initialize(unit:)
    @unit = unit
  end

  def call
    unit.destroy
  end

  private

  attr_reader :unit
end
