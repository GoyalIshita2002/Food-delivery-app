class RestaurantRating < ApplicationRecord
  belongs_to :customer
  belongs_to :restaurant
end
