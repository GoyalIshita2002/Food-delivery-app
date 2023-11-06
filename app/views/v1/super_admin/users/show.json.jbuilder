json.status do
  json.code "200" 
end

json.user do
  json.email @user.email
  json.phone @user.phone
  json.restaurant_name @user.restaurant&.name
  address= @user.restaurant.restaurant_address
  json.address do
    json.zip_code address.zip_code
    json.street address.street
    json.address1 address.address1
    json.address2 address.address2
    json.city address.city
    json.state address.state
    json.state_code address.state_code
  end
end