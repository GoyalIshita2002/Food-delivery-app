class RenameIsDeletedToIsDeleteFromDish < ActiveRecord::Migration[7.0]
  def change
    rename_column :dishes, :is_delete, :is_deleted
  end
end
