class AddLatLonOnAddress < ActiveRecord::Migration[7.0]
  def change
    add_column :customer_addresses, :latitude, :decimal
    add_column :customer_addresses, :longitude, :decimal
  end
end
