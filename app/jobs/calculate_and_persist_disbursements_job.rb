class CalculateAndPersistDisbursementsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    merchants = Merchant.weekly_completed_orders
    merchants.each do |merchant|
      new_disbursement_hash = {
        merchant: merchant,
        total_disburse_amount: merchant.orders.reduce(0) {|t, order| t + order.net_amount},
        week: start_date.cweek
      }
      ActiveRecord::Base.transaction do
        disbursement = Disbursement.create(new_disbursement_hash)
        
        orders = merchant.orders
        
        disbursement.orders =  orders
      end
    end
  end
end
