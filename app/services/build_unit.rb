# frozen_string_literal: true

class BuildUnit
  def initialize(province:, unit_type:, player:)
    @player = player
    @province = province
    @unit_type = unit_type
  end

  def call
    Unit.create(
      province: province,
      unit_type: unit_type,
      player: player,
    )
  end

  private

  attr_reader :player, :province, :unit_type
end
