json.order_history do 
  json.array! @orders do |order|
    json.restaurant_name order.restaurant&.name
    address= order.restaurant&.restaurant_address
    json.address do
      json.zip_code address.zip_code
      json.street address.street
      json.address1 address.address1
      json.address2 address.address2
      json.city address.city
      json.state address.state
    end
    json.items order.restaurant&.dishes.map(&:name)

    order.restaurant&.dishes&.each do |dish| 
      @total_price ||= 0
      @total_price += dish.price.to_f
    end
    json.total_price @total_price
    json.date "18/10/2023"
  end
end
