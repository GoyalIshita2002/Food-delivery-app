class CreateFavDishes < ActiveRecord::Migration[7.0]
  def change
    create_table :fav_dishes do |t|
      t.references :dish, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
