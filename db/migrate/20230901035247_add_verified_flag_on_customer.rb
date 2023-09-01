class AddVerifiedFlagOnCustomer < ActiveRecord::Migration[7.0]
  def change
    add_column :customers, :is_verified, :boolean, default: :false
  end
end
