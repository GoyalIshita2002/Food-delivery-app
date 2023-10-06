class DropFavouritesTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :favourites if ActiveRecord::Base.connection.table_exists?(:favourites)
  end
end
