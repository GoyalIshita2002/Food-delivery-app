class AddIsDeleteToDishAddOns < ActiveRecord::Migration[7.0]
  def change
    add_column :dish_add_ons, :is_delete, :boolean, default: false
  end
end
