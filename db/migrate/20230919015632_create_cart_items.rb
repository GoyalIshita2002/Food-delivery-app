class CreateCartItems < ActiveRecord::Migration[7.0]
  def change
    create_table :cart_items do |t|
      t.references :cart, null: false, foreign_key: true
      t.references :dish, null: false, foreign_key: true
      t.integer :quantity, default: 1
      t.decimal :ordered_price, default: 0

      t.timestamps
    end
  end
end
