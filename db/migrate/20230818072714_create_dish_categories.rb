class CreateDishCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :dish_categories do |t|
      t.references :dish, null: false, foreign_key: true
      t.references :dish_type, null: false, foreign_key: true

      t.timestamps
    end
  end
end
