json.status do
 json.code "200"
end

restaurant = @admin.reload.restaurant

json.restaurant do 
  json.id restaurant.id
  json.name restaurant.name
  json.phone restaurant.phone
  json.std_code restaurant.std_code
  json.rating restaurant.avg_rating
  json.registration_date restaurant.registration_date
  json.avg_rating restaurant.avg_rating
  json.open_for_orders restaurant.open_for_orders
  address = restaurant.restaurant_address
  json.address do
    json.id address.id
    json.address1 address.address1
    json.address2 address.address2
    json.city address.city
    json.state address.state
    json.zip_code address.zip_code
  end
  json.open_hours do 
    json.array! restaurant.open_hours do |open_hour|
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

json.restaurant_owner do
  json.id @admin.id
  json.email @admin.email
  json.owner_name @admin.user_name
  json.avatar_url @admin.avatar_url
end

json.auth_token @admin.generate_jwt