class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :itemable, polymorphic: true
  after_save :update_cart

  def update_cart
    cart_items = self.cart.cart_items
    self.cart.update( total_amount: cart_items.sum(:ordered_price), item_count: cart_items.count)
  end
end
