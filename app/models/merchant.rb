class Merchant < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :cif, presence: true

  has_many :orders
  
  scope :weekly_completed_orders, -> { includes(:orders).where(orders: {id: Order.weekly_completed_orders})}
  scope :weekly_completed_orders_for, -> (start_date) { includes(:orders).where(orders: {id: Order.weekly_completed_orders_for(start_date)})}
end
