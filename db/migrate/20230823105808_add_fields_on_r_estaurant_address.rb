class AddFieldsOnREstaurantAddress < ActiveRecord::Migration[7.0]
  def change
    rename_column :restaurant_addresses, :address, :address1
    add_column :restaurant_addresses, :address2, :string
    add_column :restaurant_addresses, :city, :string
  end
end
