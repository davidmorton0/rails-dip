# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RailsDipSeeds, :seeds do
  subject { described_class.new.call }

  it 'loads seeds' do
    expect { subject }
      .to(change(Game, :count).by(2)
      .and(change(Map, :count).by(2))
      .and(change(Player, :count).by(9))
      .and(change(Province, :count).by(79))
      .and(change(Variant, :count).by(2))
      .and(change(Unit, :count).by(9))
      .and(change(HoldOrder, :count).by(5))
      .and(change(MoveOrder, :count).by(1))
      .and(change(SupportHoldOrder, :count).by(1))
      .and(change(SupportMoveOrder, :count).by(1))
      .and(change(Order, :count).by(8)))
  end
end
