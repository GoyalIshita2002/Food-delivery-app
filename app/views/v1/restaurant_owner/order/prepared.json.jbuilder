json.status do 
  json.code "200"
end

json.orders do 
  json.array! @orders do |order| 
    json.id order.id
    json.status order.status
    if order.status == "restaurant_accepted"  
      preparation_time = order['time']
      remaining_time = preparation_time.present? ? (preparation_time - Time.now).to_i : 0
      remaining_minutes = [remaining_time / 60, 0].max
      json.remaining_minutes remaining_minutes
    end
  end
end


