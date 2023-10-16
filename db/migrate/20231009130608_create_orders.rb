class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.belongs_to :customer, null: false, foreign_key: true
      t.belongs_to :cart, null: false, foreign_key: true
      t.belongs_to :restaurant, null: false, foreign_key: true
      t.belongs_to :customer_address, null: false, foreign_key: true
      t.string :status, default: "Order Placed"

      t.timestamps
    end
  end
end
