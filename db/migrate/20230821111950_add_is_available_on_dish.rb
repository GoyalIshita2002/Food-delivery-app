class AddIsAvailableOnDish < ActiveRecord::Migration[7.0]
  def change
    add_column :dishes, :is_available, :boolean, default: true
  end
end
