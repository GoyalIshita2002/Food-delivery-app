
json.restaurant do 
  json.id restaurant.id
  json.name restaurant.name
  json.phone restaurant.phone
  json.registration_date restaurant.registration_date
  json.lock_menu restaurant.lock_menu 
  json.main_image_url restaurant.main_image_url
  address = restaurant.restaurant_address
  json.address do
    json.id address.id
    json.address1 address.address1
    json.address2 address.address2
    json.street address.street
    json.city address.city
    json.state address.state
    json.zip_code address.zip_code
    json.state_code address.state_code
  end
  json.open_hours do 
    json.array! restaurant.open_hours do |open_hour|
      json.id open_hour.id
      json.day open_hour.day
      json.start_time open_hour.start_time
      json.end_time open_hour.end_time
      json.split_hours do 
        json.array! open_hour.split_hours do |split_hour|
          json.id split_hour.id
          json.start_at split_hour.start_at
          json.end_at split_hour.end_at
        end
      end
    end
  end
  json.margin_from_restaurant restaurant&.restaurant_margin&.margin_percent || 0
  json.margin_from_customer restaurant&.customer_margin&.margin_percent || 0
end
 
admin_user = restaurant.admin_user

json.restaurant_admin do
  json.id admin_user.id
  json.email admin_user.email
  json.password admin_user.encrypted_password
  json.jti admin_user.jti
  json.owner_name admin_user.user_name
  json.avatar_url admin_user.avatar_url 
end