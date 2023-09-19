json.cart_items do
  json.array! cart.cart_items do |item|
    json.partial! "v1/customer/cart_items/cart_item", locals: { item: item }
  end
end 