FactoryBot.define do
  factory :shopper do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    nif { (Faker::Number.number(digits: 9)).to_s }
  end
end
