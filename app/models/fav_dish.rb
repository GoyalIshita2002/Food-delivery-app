class FavDish < ApplicationRecord
  belongs_to :dish
  belongs_to :customer
end
