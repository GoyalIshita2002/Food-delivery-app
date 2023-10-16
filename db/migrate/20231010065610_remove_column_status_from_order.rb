class RemoveColumnStatusFromOrder < ActiveRecord::Migration[7.0]
  def change
    remove_column :orders, :status, :string, default: "Order Placed"
  end
end
