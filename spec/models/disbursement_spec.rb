require 'rails_helper'

RSpec.describe Disbursement, type: :model do
  it { is_expected.to belong_to(:merchant) }
end
