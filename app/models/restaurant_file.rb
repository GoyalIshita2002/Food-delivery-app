class RestaurantFile < ApplicationRecord
  belongs_to :restaurant
  has_one_attached :file
end
