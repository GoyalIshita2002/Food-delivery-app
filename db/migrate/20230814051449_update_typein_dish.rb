class UpdateTypeinDish < ActiveRecord::Migration[7.0]
  def change
    change_column :dishes, :type, :string
  end
end
