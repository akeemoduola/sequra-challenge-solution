require 'rails_helper'

RSpec.describe Order, type: :model do
  it { is_expected.to belong_to(:merchant) } 
  it { is_expected.to belong_to(:shopper) }
  it { is_expected.to validate_numericality_of(:amount) }
end
