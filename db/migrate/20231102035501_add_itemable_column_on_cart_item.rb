class AddItemableColumnOnCartItem < ActiveRecord::Migration[7.0]
  def change
    add_reference :cart_items, :itemable, polymorphic: true, index: true
  end
end
