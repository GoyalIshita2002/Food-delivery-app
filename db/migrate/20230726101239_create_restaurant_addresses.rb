class CreateRestaurantAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :restaurant_addresses do |t|
      t.references :restaurant, null: false, foreign_key: true
      t.string :street
      t.string :address
      t.string :zip_code
      t.string :state
      t.decimal :latitude
      t.decimal :longitude

      t.timestamps
    end

    add_index :restaurant_addresses, :latitude
    add_index :restaurant_addresses, :longitude
  end
end
