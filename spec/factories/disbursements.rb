FactoryBot.define do
  factory :disbursement do
    merchant
    total_disburse_amount { 9.99 }
    week { 1 }
  end
end
