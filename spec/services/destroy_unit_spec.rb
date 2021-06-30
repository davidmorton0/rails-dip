# frozen_string_literal: true

RSpec.describe DestroyUnit do
  subject { described_class.new(**params) }

  let(:params) { { unit: unit } }
  let(:unit) { create(:unit) }

  before { unit }

  it 'destroys a unit' do
    expect { subject.call }.to change(Unit, :count).by(-1)
  end
end
