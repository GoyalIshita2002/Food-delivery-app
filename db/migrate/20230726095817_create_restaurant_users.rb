class CreateRestaurantUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :restaurant_users do |t|
      t.references :restaurant, null: false, foreign_key: true
      t.references :admin_user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
