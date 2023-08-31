class AddStdOnRestaurant < ActiveRecord::Migration[7.0]
  def change
    add_column :restaurants, :std_code, :string
  end
end
