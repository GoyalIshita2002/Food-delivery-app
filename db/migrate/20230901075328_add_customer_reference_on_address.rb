class AddCustomerReferenceOnAddress < ActiveRecord::Migration[7.0]
  def change
    add_reference :customer_addresses, :customer, null: false, foreign_key: true
  end
end
