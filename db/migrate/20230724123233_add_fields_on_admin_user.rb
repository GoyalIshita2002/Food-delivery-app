class AddFieldsOnAdminUser < ActiveRecord::Migration[7.0]
  def change
    add_column :admin_users, :first_name, :string
    add_column :admin_users, :last_name, :string
    add_column :admin_users, :role, :integer

    add_column :admin_users, :jti, :string, null: false
    add_index :admin_users, :jti, unique: true
  end
end
