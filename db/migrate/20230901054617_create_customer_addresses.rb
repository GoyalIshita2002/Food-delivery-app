class CreateCustomerAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :customer_addresses do |t|
      t.string :street, null:false
      t.string :address, null:false
      t.string :zip_code, null:false
      t.string :state, null:false
      t.string :country

      t.timestamps
    end
  end
end
