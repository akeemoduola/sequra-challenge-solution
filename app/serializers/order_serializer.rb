class OrderSerializer < ActiveModel::Serializer
  attributes :id, :merchant_id, :shopper_id, :amount, :completed_at

  def amount
    ActiveSupport::NumberHelper.number_to_currency(object.amount)
  end
  
  def completed_at
    object.completed_at.strftime("%Y-%m-%d")
  end
end
