class AddColumnToAdminUser < ActiveRecord::Migration[7.0]
  def change
    add_column :admin_users, :is_blocked, :boolean, default: false
  end
end
