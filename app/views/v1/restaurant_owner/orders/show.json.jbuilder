json.status do 
    json.code "200"
end

order = @order

json.order do 
    json.id order.id
    json.status order.status
    preparation_time = order.time
    remaining_time = preparation_time.present? ? (preparation_time - Time.now).to_i : 0
    remaining_minutes = [remaining_time / 60, 0].max
    json.time_remaining remaining_minutes
    driver = order.driver
    if order.driver.present?
        json.driver_name  driver.full_name
        json.driver_phone "#{driver.std_code}-#{driver.phone}"
    end
    customer = order.customer
    if order.customer.present?
        json.customer_name customer.username
        json.customer_phone "#{customer.std_code}-#{customer.phone}"
    end
    customer_address = order.customer_address
    if customer_address.present?
       json.customer_address customer_address.full_address
    end
    order_note = order.order_note
    if order_note.present?
        json.order_note order_note.content
    end

    cart_items = order.cart.cart_items
    json.total order.cart.total_amount.to_f
    if cart_items.present?
        json.dishes cart_items do |item|
            json.name item.itemable.name
            json.quantity item.quantity
        end
    end
end



  
 

  