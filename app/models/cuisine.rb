class Cuisine < ApplicationRecord
  has_many :restaurants, through: :restaurant_cuisines
end
