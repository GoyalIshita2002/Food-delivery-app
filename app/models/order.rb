class Order < ApplicationRecord
  # belongs_to :customer
  belongs_to :customer
  belongs_to :cart
  belongs_to :restaurant
  belongs_to :customer_address
  has_one :order_note
  
  enum :status, [ :order_placed, :order_cancelled, :order_pending ]
end
