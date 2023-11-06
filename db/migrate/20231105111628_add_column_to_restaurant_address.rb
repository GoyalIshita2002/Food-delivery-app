class AddColumnToRestaurantAddress < ActiveRecord::Migration[7.0]
  def change
    add_column :restaurant_addresses, :state_code, :string, default: nil
  end
end
