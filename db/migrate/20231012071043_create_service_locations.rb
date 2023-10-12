class CreateServiceLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :service_locations do |t|
      t.string :address
      t.string :street
      t.string :state
      t.string :country
      t.integer :vehicle
      t.decimal :latitude
      t.decimal :longitude
      t.references :driver, null: false, foreign_key: true

      t.timestamps
    end
  end
end
