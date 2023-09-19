json.status do
  json.code "200"
  json.message "Item Added to Cart"
end

json.cart do
  json.partial! 'v1/customer/carts/cart', locals: {cart: @cart}
end