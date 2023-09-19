json.cart do
  json.partial! 'cart', locals: {cart: @cart}
end