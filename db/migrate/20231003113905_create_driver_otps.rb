class CreateDriverOtps < ActiveRecord::Migration[7.0]
  def change
    create_table :driver_otps do |t|
      t.string :otp
      t.references :driver, null: false, foreign_key: true

      t.timestamps
    end
  end
end
