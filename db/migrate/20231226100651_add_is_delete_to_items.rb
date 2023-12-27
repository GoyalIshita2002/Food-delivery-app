class AddIsDeleteToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :is_delete, :boolean, default: false
  end
end
