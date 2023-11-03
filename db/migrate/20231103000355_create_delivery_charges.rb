class CreateDeliveryCharges < ActiveRecord::Migration[7.0]
  def change
    create_table :delivery_charges do |t|
      t.float :min_distance
      t.float :max_distance
      t.integer :charge

      t.timestamps
    end
  end
end
