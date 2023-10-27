json.status do 
    json.code "200"
   end

json.orders do 
 json.array! @orders do |orders|
    json.id orders.id
    json.restaurant_name orders.restaurant.name
    json.admin_email orders.restaurant.admin_user.email
    json
 end
end