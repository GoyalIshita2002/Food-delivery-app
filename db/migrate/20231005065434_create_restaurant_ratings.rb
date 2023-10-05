class CreateRestaurantRatings < ActiveRecord::Migration[7.0]
  def change
    create_table :restaurant_ratings do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :restaurant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
