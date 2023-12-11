json.status do 
    json.code "200"
end
json.total_amount @orders.joins(:cart).sum("carts.total_amount").to_f
json.orders do 
    json.array! @orders do |order| 
      json.id order.id
      json.status order.status
      json.restaurant_id order.restaurant_id
      if order.status == "restaurant_accepted"  
        preparation_time = order['time']
        remaining_time = preparation_time.present? ? (preparation_time - Time.now).to_i : 0
        remaining_minutes = [remaining_time / 60, 0].max
        json.remaining_minutes remaining_minutes
      end
      total_price = 0
      json.items_and_quantities order.cart.cart_items.map { |cart_item| 
        total_price += cart_item.ordered_price
        {
          item: cart_item.itemable&.name,
          quantity: cart_item.quantity,
          price: cart_item.ordered_price
        }
      }
      json.sum_of_prices total_price
    end
  end