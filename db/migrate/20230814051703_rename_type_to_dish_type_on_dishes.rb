class RenameTypeToDishTypeOnDishes < ActiveRecord::Migration[7.0]
  def change
    rename_column :dishes, :type, :dish_type
  end
end
