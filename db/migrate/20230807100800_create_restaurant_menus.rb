class CreateRestaurantMenus < ActiveRecord::Migration[7.0]
  def change
    create_table :restaurant_menus do |t|
      t.references :restaurant, null: false, foreign_key: true
      t.decimal :min_price
      t.decimal :max_price

      t.timestamps
    end
  end
end
