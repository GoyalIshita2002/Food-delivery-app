json.status do 
    json.code "200"
  end
  
json.orders do 
json.array! @orders do |order| 
    json.id order.id
    json.customer do
    json.phone order.customer.phone
    json.std_code order.customer.std_code
    end
end
end
  