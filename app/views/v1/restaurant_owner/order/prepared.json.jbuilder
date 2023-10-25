json.status do 
    json.code "200"
   end
json.orders do 
  json.array! @orders_prepared do |orders|
    json.id orders.id
    json.status "prepared"
  end
end