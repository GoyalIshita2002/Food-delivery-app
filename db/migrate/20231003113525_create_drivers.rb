class CreateDrivers < ActiveRecord::Migration[7.0]
  def change
    create_table :drivers do |t|
      t.string :full_name
      t.date :dob
      t.string :email
      t.text :address
      t.string :phone
      t.string :std_code
      t.boolean :is_verified, default: false

      t.timestamps
    end
  end
end
