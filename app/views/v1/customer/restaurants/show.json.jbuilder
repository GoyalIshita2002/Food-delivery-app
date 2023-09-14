json.code "200"
json.success true

json.restaurant do
  json.partial! 'restaurant', locals: { restaurant: @restaurant }
  json.address do
    json.partial! 'restaurant_address', locals: { address: @restaurant.restaurant_address }
  end
  json.open_hours do 
    json.array! @restaurant.open_hours do |open_hour|
      json.id open_hour.id
      json.day open_hour.day
      json.start_time open_hour.start_time
      json.end_time open_hour.end_time
      json.split_hours do 
        json.array! open_hour.split_hours do |split_hour|
          json.start_at split_hour.start_at
          json.end_at split_hour.end_at
        end
      end
    end
  end
end