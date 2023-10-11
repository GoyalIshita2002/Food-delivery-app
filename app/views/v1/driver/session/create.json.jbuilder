json.status do 
    json.code "200"
    json.message "signin successful"
end

json.driver do
  json.id @driver.id
  json.phone @driver.phone
  json.std_code @driver.std_code
end 

json.service_details do
  json.vehicle @driver.service_detail&.vehicle
  json.locality @driver.service_detail&.locality
end

json.profile_info do
  json.name @driver.full_name
  json.email @driver.email
  json.dob @driver.dob
  json.address @driver.address
end

json.documents do
  json.documents @driver.documents do |document|
    json.name document&.name
    json.front_url document&.front_url
    json.back_url document&. back_url
  end
end

json.auth_token @driver.generate_jwt