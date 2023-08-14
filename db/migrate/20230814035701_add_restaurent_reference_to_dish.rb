class AddRestaurentReferenceToDish < ActiveRecord::Migration[7.0]
  def change
    add_reference :dishes, :restaurant, null: false, foreign_key: true
  end
end
