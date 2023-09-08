class AddLockMenuOnRestaurant < ActiveRecord::Migration[7.0]
  def change
    add_column :restaurants, :lock_menu, :boolean, default: :false
  end
end
