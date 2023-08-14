class AddOpenForOrderToRestaurant < ActiveRecord::Migration[7.0]
  def change
    add_column :restaurants, :open_for_orders, :boolean, default: false
  end
end
