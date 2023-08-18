class DishCategory < ApplicationRecord
  belongs_to :dish
  belongs_to :dish_type
end
