json.status do
  json.code "200"
  json.message "Item removed from cart"
end

json.cart do
  json.partial! 'v1/customer/carts/cart', locals: {cart: @cart}
end