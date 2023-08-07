class RestaurantOpenDay < ApplicationRecord
  belongs_to :open_day
  belongs_to :restaurant
end
