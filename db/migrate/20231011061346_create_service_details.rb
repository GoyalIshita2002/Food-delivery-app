class CreateServiceDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :service_details do |t|
      t.integer :vehicle
      t.text :locality
      t.references :driver, null: false, foreign_key: true

      t.timestamps
    end
  end
end
