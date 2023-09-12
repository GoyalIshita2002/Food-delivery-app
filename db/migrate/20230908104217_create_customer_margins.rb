class CreateCustomerMargins < ActiveRecord::Migration[7.0]
  def change
    create_table :customer_margins do |t|
      t.references :restaurant, null: false, foreign_key: true
      t.integer :margin_percent

      t.timestamps
    end
  end
end