class CreateRestaurantFiles < ActiveRecord::Migration[7.0]
  def change
    create_table :restaurant_files do |t|
      t.string :name
      t.references :restaurant, null: false, foreign_key: true

      t.timestamps
    end
    add_column :restaurant_files, :file, :string 
  end
end
