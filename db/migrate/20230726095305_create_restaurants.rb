class CreateRestaurants < ActiveRecord::Migration[7.0]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.float :avg_rating
      t.string :phone

      t.timestamps
    end
  end
end
