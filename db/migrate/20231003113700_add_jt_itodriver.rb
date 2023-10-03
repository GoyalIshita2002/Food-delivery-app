class AddJtItodriver < ActiveRecord::Migration[7.0]
  def change
    add_column :drivers, :jti, :string
    add_index :drivers, :jti,unique: true 
  end
end
