class RemoveDishReferenceFromCartItem < ActiveRecord::Migration[7.0]
  def change
    remove_reference :cart_items, :dish, foreign_key: true
  end
end
