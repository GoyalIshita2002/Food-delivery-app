json.code "200"
json.success true

json.details do
  json.total_count @pagy.count
  json.total_pages @pagy.pages
end

json.driver do 
  json.array! @orders do |order|
    json.id order.id
    json.customer_name order.customer.username
    json.restaurant_name order.restaurant.name
    json.status order.status
    json.dishes do
      json.array! order.cart.cart_items.map { |cart_item| cart_item.itemable&.name }
    end
    json.total_amount order.cart.total_amount
  end
end
