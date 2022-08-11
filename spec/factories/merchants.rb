FactoryBot.define do
  factory :merchant do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    cif { (Faker::Number.number(digits: 7)).to_s }
  end
end
