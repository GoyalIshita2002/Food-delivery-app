class CreateOrderAgents < ActiveRecord::Migration[7.0]
  def change
    create_table :order_agents do |t|
      t.references :order, null: false, foreign_key: true
      t.references :driver, null: false, foreign_key: true

      t.timestamps
    end
  end
end
