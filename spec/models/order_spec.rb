require 'rails_helper'

RSpec.describe Order, type: :model do
  before do
    travel_to Time.parse("2022-08-09")
  end

  it { is_expected.to belong_to(:merchant) } 
  it { is_expected.to belong_to(:shopper) }
  it { is_expected.to validate_numericality_of(:amount) }

  it 'calculates the correct net amount' do
    order = create(:order, amount: 45.00)
    expect(order.net_amount).to eq(44.55)

    order = create(:order, amount: 145.00)
    expect(order.net_amount.round(2)).to eq(143.62)

    order = create(:order, amount: 305.00)
    expect(order.net_amount.round(2)).to eq(302.41)
  end

  it "includes orders completed in the week" do
    order1 = create(:order, completed_at: 1.week.ago)
    order2 = create(:order, completed_at: 6.day.ago)
    order3 = create(:order, completed_at: 3.day.ago)
    order4 = create(:order, completed_at: Time.now)
    
    expect(Order.weekly_completed_orders).to match_array([order1,order2,order3])
  end

  after do
    travel_back
  end
end
