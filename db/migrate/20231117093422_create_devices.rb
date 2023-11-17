class CreateDevices < ActiveRecord::Migration[7.0]
  def change
    create_table :devices do |t|
      t.string :device_type
      t.string :device_token
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
