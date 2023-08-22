class CreateDishAddOns < ActiveRecord::Migration[7.0]
  def change
    create_table :dish_add_ons do |t|
      t.string :name
      t.integer :min_quantity
      t.integer :max_quantity
      t.references :restaurant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
