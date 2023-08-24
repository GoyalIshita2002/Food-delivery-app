class AddRegistrationDateOnRestaurant < ActiveRecord::Migration[7.0]
  def change
    add_column :restaurants, :registration_date, :string
  end
end
