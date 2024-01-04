json.status do
  json.code "200"
end

statuses_mapping = {
  'restaurant_accepted' => 'under_preparation',
  'driver_picked_up' => 'on_the_way',
  'delivered' => 'delivered'
}

statuses_to_print = ['restaurant_accepted', 'driver_picked_up', 'delivered']

statuses_to_print.each do |status|
  mapped_status = statuses_mapping[status]
  json.set!(mapped_status.to_s) do
    json.array!(@orders[status]) do |order|
      json.id order.id
      total_amount = order.cart.cart_items.sum { |cart_item| cart_item.itemable&.price.to_f }

      json.dishes do
        json.array! order.cart.cart_items do |cart_item|
          json.name cart_item.itemable&.name
          json.price cart_item.itemable&.price
        end
      end

      json.total_amount total_amount
      json.restaurant order.restaurant.name
      json.ordered_by order.customer.username
      json.delivery_boy order.order_agent&.driver&.full_name
    end
  end
end


