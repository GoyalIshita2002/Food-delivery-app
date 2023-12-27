class AddIsDeleteToDishes < ActiveRecord::Migration[7.0]
  def change
    add_column :dishes, :is_delete, :boolean, default: false
  end
end
