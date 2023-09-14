class AddCityOnCustomerAddress < ActiveRecord::Migration[7.0]
  def change
    add_column :customer_addresses, :city, :string, default: ""
  end
end
