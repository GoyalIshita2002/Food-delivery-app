json.customer do
  json.id current_customer.id
  json.name current_customer.username
  json.email current_customer.email
  json.phone current_customer.phone
  json.std_code current_customer.std_code
  json.image_url current_customer.avatar_url
  json.data_of_birth current_customer.dob 
  json.date_of_anniversary current_customer.doa 
  json.is_verified current_customer.is_verified 
end
json.auth_token current_customer.generate_jwt
