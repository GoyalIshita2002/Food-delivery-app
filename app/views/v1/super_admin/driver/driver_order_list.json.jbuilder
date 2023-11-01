json.code "200"
json.success true

json.driver do 
  json.array! @orders do |order|
    json.id order.id
    json.customer_name order.customer.username
    json.restaurant_name order.restaurant.name
    json.status order.status
    json.dishes do
      json.array! order.cart.cart_items.map { |cart_item| cart_item.dish.name }
    end
    json.total_amount order.cart.total_amount
  end
end
