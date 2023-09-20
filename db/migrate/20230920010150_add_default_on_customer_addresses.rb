class AddDefaultOnCustomerAddresses < ActiveRecord::Migration[7.0]
  def change
    add_column :customer_addresses, :is_default, :boolean, default:false
    add_column :customer_addresses, :address_type, :integer, default: 0
  end
end
