class AddColumnToOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :time, :datetime, default: "0"
  end
end
