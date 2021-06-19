require 'rails_helper'

RSpec.describe Unit, type: :model do
  subject { described_class.new(unit_type: 'Army', province: province) }

  let(:province) { build(:province) }
  let(:target_province) { build(:province) }

  it 'returns the unit type' do
    expect(subject.unit_type).to eq 'Army'
  end
  
  it 'returns the unit province' do
    expect(subject.province).to eq province
  end

  it 'moves to a province' do
    expect { subject.move(target_province) }.to change(subject, :province)
      .from(province).to(target_province)
  end

  it 'assigns a move order' do
    target_province = create(:province)
    order_details = { game: 1, season: 'Autumn', year: '1901' }

    expect { subject.assign_move_order(target_province, order_details) }.to change(Order, :count).by(1)
    expect(Order.last).to have_attributes(unit: subject, target_province: target_province)
  end
end
