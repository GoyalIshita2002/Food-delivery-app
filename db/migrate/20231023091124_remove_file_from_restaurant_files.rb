class RemoveFileFromRestaurantFiles < ActiveRecord::Migration[7.0]
  def change
    remove_column :restaurant_files, :file, :string
  end
end
