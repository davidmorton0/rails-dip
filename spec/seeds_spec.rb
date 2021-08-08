# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Rails do
  subject { described_class.application.load_seed }

  it 'loads seeds' do
    expect { subject }
      .to(change(Game, :count).by(2)
      .and(change(Map, :count).by(2))
      .and(change(Player, :count).by(2))
      .and(change(Province, :count).by(79))
      .and(change(Variant, :count).by(2))
      .and(change(Unit, :count).by(1)))
  end
end
