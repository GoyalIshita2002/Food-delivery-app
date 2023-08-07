class Category < ApplicationRecord
  has_many :restaurants, through: :restaurant_categories
end
