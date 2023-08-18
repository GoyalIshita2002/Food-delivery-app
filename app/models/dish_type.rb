class DishType < ApplicationRecord
  has_many :dish_category
  has_many :dishes, through: :dish_category
end
