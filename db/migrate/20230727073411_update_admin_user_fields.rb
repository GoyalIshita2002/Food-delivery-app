class UpdateAdminUserFields < ActiveRecord::Migration[7.0]
  def change
    remove_column :admin_users, :first_name
    remove_column :admin_users, :last_name
    
    add_column :admin_users, :user_name, :string 
    add_column :admin_users, :is_verified, :boolean
  end
end
