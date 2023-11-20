json.status do 
    json.code "200"
   end

json.orders do 
 json.array! @orders do |orders|
    json.id orders.id
    json.status orders.status
 end
end