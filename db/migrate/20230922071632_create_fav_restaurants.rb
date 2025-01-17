class CreateFavRestaurants < ActiveRecord::Migration[7.0]
  def change
    create_table :fav_restaurants do |t|
      t.references :restaurant, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
