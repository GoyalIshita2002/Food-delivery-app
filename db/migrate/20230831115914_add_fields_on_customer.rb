class AddFieldsOnCustomer < ActiveRecord::Migration[7.0]
  def change
    add_column :customers, :username, :string
    add_column :customers, :phone, :string
    add_column :customers, :std_code, :string
    add_column :customers, :dob, :date
    add_column :customers, :doa, :date

    add_column :customers, :jti, :string, null: false
    add_index :customers, :jti, unique: true
  end
end

