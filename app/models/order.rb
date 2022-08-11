class Order < ApplicationRecord
  belongs_to :merchant
  belongs_to :shopper
  belongs_to :disbursement, optional: true

  validates :amount, numericality: { greater_than_or_equal_to: 0.01 }

  scope :weekly_completed_orders, -> { where(:completed_at => 1.week.ago.all_week)}
  scope :weekly_completed_orders_for, -> (start_date) { where(:completed_at => (start_date.beginning_of_day).all_week)}

  def net_amount
    case amount
    when 0.01...50.0 then amount - (0.01 * amount)
    when 50.0..300.0 then amount - (0.0095 * amount)
    when 300.0.. then amount - (0.0085 * amount)
    end
  end
end
