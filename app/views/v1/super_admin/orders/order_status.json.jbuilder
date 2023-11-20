json.status do
   json.code "200"
 end
 json.orders do
   json.array! @orders do |order|
     json.id order.id
     total_amount = 0
     json.dishes do
       json.array! order.cart.cart_items do |cart_item|
         json.name cart_item.itemable.name
         json.price cart_item.itemable.price
         total_amount += cart_item.itemable.price.to_f
       end
     end
     json.total_amount total_amount
     json.restaurant order.restaurant.name
     json.ordered_by order.customer.username
     json.delivery_boy order.order_agent&.driver&.full_name
   end
 end
 
 