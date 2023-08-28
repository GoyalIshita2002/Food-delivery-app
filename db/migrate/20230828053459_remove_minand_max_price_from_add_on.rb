class RemoveMinandMaxPriceFromAddOn < ActiveRecord::Migration[7.0]
  def change
    remove_column :dish_add_ons, :min_quantity, :max_quantity
  end
end
