class AddDishAddOnIdOnDishItem < ActiveRecord::Migration[7.0]
  def change
    add_reference :dish_items, :dish_add_on, foreign_key: true
  end
end
