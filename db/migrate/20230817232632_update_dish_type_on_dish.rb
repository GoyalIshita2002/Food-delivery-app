class UpdateDishTypeOnDish < ActiveRecord::Migration[7.0]
  def change
    change_column :dishes, :dish_type, 'integer USING CAST(dish_type AS integer)'
  end
end
