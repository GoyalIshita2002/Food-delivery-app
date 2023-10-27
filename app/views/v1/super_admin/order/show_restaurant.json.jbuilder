json.status do 
    json.code "200"
   end
json.restaurant do 
json.array! @restaurant do |restaurant|
    json.id restaurant.id
    json.name restaurant.name
    json.email restaurant.admin_user.email
    json.phone_number restaurant.phone
    total_price = restaurant&.orders&.reject { |order| order.status == "denied" }&.sum { |order| order.cart&.total_amount.to_f }
    json.total_price total_price || 0
    end
end