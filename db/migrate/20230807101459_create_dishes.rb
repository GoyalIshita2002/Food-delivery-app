class CreateDishes < ActiveRecord::Migration[7.0]
  def change
    create_table :dishes do |t|
      t.string :name
      t.integer :type
      t.decimal :price
      t.text :description
      t.references :restaurant_menu, null: false, foreign_key: true

      t.timestamps
    end
  end
end
