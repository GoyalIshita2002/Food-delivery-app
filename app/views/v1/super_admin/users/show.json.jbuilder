json.status do
  json.code "200" 
end

json.user do
  json.email @user.email
  json.phone @user.phone
  json.restaurant_name @user.username
  json.is_blocked @user.is_blocked
  address = @user.addresses.default || @user.addresses.last 
  if address.present?
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
end