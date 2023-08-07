class CreateRestaurantOpenDays < ActiveRecord::Migration[7.0]
  def change
    create_table :restaurant_open_days do |t|
      t.references :open_day, null: false, foreign_key: true
      t.references :restaurant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
