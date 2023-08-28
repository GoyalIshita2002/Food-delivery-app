class AddQuantityFieldsonItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :min_quantity, :integer
    add_column :items, :max_quantity, :integer
  end
end
