FactoryBot.define do
  factory :order do
    merchant
    shopper
    amount { 9.99 }
    completed_at { "2022-08-11 07:07:09" }
  end
end
