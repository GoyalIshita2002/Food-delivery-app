json.status do
    json.code "200"
  end
json.transaction do
    json.array! @orders do |order|
      json.order_id order.id
      json.name order.customer.username
      json.restaurant_name order.restaurant.name
      json.item_number 13
      json.purchased_items order.cart.cart_items.map {  |cart_item| "#{cart_item.dish.name} (#{cart_item.quantity})"}
      json.total_spend order.cart.total_amount.to_f
    end  
  end