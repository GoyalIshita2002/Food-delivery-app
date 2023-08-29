# frozen_string_literal: true

class DishItem < ApplicationRecord
  belongs_to :dish
  belongs_to :item
  belongs_to :dish_add_on
end
