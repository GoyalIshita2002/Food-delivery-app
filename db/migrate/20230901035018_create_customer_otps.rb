class CreateCustomerOtps < ActiveRecord::Migration[7.0]
  def change
    create_table :customer_otps do |t|
      t.string :otp, limit: 4
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
