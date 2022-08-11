require 'rails_helper'

RSpec.describe Shopper, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:nif) }

  it { is_expected.to allow_value("akeem@oduola.tolulope").for(:email) }
  it { is_expected.to_not allow_value("foobar").for(:email) }
end
