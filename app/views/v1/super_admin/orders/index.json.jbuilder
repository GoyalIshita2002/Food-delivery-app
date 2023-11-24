json.status do
  json.code "200"
end
json.details do
  json.total_count @pagy.count
  json.total_pages @pagy.pages
end
json.transaction do
  json.array! @orders do |order|
    json.order_id order.id
    json.name order.customer.username
    json.restaurant_name order.restaurant.name
    sum = 0  
    order.cart.cart_items.map do |cart_item|
      sum += cart_item.quantity  
      "#{cart_item.quantity}"   
    end
    json.total_quantity sum 
    json.purchased_items order.cart.cart_items.map { |cart_item| "#{cart_item.itemable&.name} (#{cart_item.quantity})" }
    json.total_spend order.cart.total_amount.to_f
  end
end