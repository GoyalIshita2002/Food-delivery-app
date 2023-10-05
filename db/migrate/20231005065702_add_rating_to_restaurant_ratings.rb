class AddRatingToRestaurantRatings < ActiveRecord::Migration[7.0]
  def change
    add_column :restaurant_ratings, :rating, :integer, default: 0
  end
end
