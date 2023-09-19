class CreateCarts < ActiveRecord::Migration[7.0]
  def change
    create_table :carts do |t|
      t.references :customer, null: false, foreign_key: true
      t.decimal :total_amount, default: 0
      t.integer :item_count, default: 0
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
