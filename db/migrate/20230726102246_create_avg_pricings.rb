class CreateAvgPricings < ActiveRecord::Migration[7.0]
  def change
    create_table :avg_pricings do |t|
      t.references :restaurant, null: false, foreign_key: true
      t.integer :members
      t.float :price
      t.float :min_price
      t.float :max_price
      t.string :currency_symbol

      t.timestamps
    end
  end
end
