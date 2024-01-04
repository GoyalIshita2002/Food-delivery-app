class AddIsBlockedOnCustomer < ActiveRecord::Migration[7.0]
  def change
    add_column :customers, :is_blocked, :boolean, default: :false
  end
end
