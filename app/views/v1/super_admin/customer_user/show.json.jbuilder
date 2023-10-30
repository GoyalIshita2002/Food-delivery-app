json.status do
  json.code "200"
end
json.customer_user do
  json.image_url @customer_user.avatar_url
  json.email @customer_user.email
  json.phone @customer_user.phone
 json.addresses @customer_user&.addresses do |address|
    json.zip_code address.zip_code
    json.street address.street
    json.address1 address.address
    json.city address.city
    json.state address.state
  end  
end
