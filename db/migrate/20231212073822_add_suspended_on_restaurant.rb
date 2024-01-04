class AddSuspendedOnRestaurant < ActiveRecord::Migration[7.0]
  def change
    add_column :restaurants, :suspended , :boolean, default: :false
  end
end
