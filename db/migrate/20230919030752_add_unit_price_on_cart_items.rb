class AddUnitPriceOnCartItems < ActiveRecord::Migration[7.0]
  def change
    add_column :cart_items, :unit_price, :decimal
  end
end
