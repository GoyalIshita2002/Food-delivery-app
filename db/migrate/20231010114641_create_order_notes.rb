class CreateOrderNotes < ActiveRecord::Migration[7.0]
  def change
    create_table :order_notes do |t|
      t.text :content
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
