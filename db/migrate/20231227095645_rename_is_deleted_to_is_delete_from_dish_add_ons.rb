class RenameIsDeletedToIsDeleteFromDishAddOns < ActiveRecord::Migration[7.0]
  def change
    rename_column :dish_add_ons, :is_delete, :is_deleted
  end
end
