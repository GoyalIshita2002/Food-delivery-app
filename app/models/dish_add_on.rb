class DishAddOn < ApplicationRecord
  belongs_to :restaurant
  has_many :items, dependent: :destroy 
end
