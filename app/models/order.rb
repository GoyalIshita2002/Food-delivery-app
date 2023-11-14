class Order < ApplicationRecord
  # belongs_to :customer
  belongs_to :customer
  belongs_to :cart
  belongs_to :restaurant
  belongs_to :customer_address
  has_one :order_note
  has_one :order_agent
  belongs_to :driver , optional: true
  has_many :customer_feedbacks
  
  enum :status, { pending: 0, admin_accepted: 1, restaurant_accepted: 2, ready_to_pick: 3, driver_picked_up: 4, delivered: 5, admin_cancelled: 6, restaurant_cancelled: 7, expired_at_restaurant: 8 , customer_denied: 9}

  # def assign_driver
  #   driver_localities = ServiceLocation.all
  #   if driver_localities.present?
  #     order_without_driver = self
  #     if order_without_driver.present?
  #       customer_address = order_without_driver.customer_address
  #       if customer_address.present?
  #         matching_location = driver_localities.find do |location|
  #           location.latitude == customer_address.latitude &&
  #             location.longitude == customer_address.longitude
  #         end
  #         if matching_location.present?
  #           order_without_driver.update(driver_id: matching_location.driver_id)
  #         end
  #       end
  #     end
  #   end
  # end

end
