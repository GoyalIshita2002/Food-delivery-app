class RenameIsDeletedToIsDeleteFromDishAddOnsItem < ActiveRecord::Migration[7.0]
  def change
    rename_column :items, :is_delete, :is_deleted
  end
end
