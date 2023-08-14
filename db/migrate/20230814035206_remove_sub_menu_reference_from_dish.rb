class RemoveSubMenuReferenceFromDish < ActiveRecord::Migration[7.0]
  def change
    remove_reference :dishes, :restaurant_menu, null: false, foreign_key: true
  end
end
