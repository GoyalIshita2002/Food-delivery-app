class RemoveDishTypeFromDish < ActiveRecord::Migration[7.0]
  def change
    remove_column :dishes, :dish_type
  end
end
