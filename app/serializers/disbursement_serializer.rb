class DisbursementSerializer < ActiveModel::Serializer
  attributes :id, :merchant_id, :total_disburse_amount, :week

  has_many :orders

  def total_disburse_amount
    ActiveSupport::NumberHelper.number_to_currency(object.total_disburse_amount)
  end
end
