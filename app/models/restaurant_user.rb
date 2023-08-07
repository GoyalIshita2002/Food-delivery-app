class RestaurantUser < ApplicationRecord
  belongs_to :restaurant
  belongs_to :admin_user
end
