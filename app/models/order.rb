class Order < ApplicationRecord
  belongs_to :customer
  belongs_to :cart
  belongs_to :restaurant
  belongs_to :customer_address
  has_one :order_note
  has_one :order_agent
  has_many :customer_feedbacks
  has_one :driver, through: :order_agent
  
  enum :status, { pending: 0, admin_accepted: 1, restaurant_accepted: 2, ready_to_pick: 3, driver_picked_up: 4, delivered: 5, admin_cancelled: 6, restaurant_cancelled: 7, expired_at_restaurant: 8 , customer_denied: 9}

  RESTAURANT_STATUSES = [ :restaurant_accepted, :ready_to_pick, :restaurant_cancelled, :expired_at_restaurant]

  def self.filter_by_duration(duration)
    case duration.to_sym
    when :weekly
      self.where(created_at: Time.now.in_time_zone('CET').beginning_of_week.utc...Time.now.in_time_zone('CET').end_of_week.utc)
    when :monthly
      self.where(created_at: Time.now.in_time_zone('CET').beginning_of_month.utc...Time.now.in_time_zone('CET').end_of_month.utc)
    end
  end
end

