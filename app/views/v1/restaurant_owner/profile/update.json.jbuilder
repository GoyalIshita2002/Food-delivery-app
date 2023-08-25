json.status do
 json.code "200"
 json.message "Restaurant created successfully"
end

restaurant = current_admin_user.reload.restaurants.reload.last

json.restaurant do 
  json.id restaurant.id
  json.name restaurant.name
  json.phone restaurant.phone
  json.rating restaurant.avg_rating
  json.registration_date restaurant.registration_date
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
 
admin_user = restaurant.admin_users.last

json.restaurant_admin do
  json.id admin_user.id
  json.email admin_user.email
  json.owner_name admin_user.user_name
  json.avatar_url admin_user.avatar_url
end