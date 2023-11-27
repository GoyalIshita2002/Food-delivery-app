json.status do 
    json.code "200"
   end

json.orders do 
 json.array! @orders_without_agent do |orders|
    json.id orders.id
    json.status "Driver has to be assigned"
 end
end