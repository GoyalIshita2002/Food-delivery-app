json.profile_info do
  json.id @driver.id
  json.image @driver.avatar_url
  json.name @driver.full_name
  json.email @driver.email
  json.dob @driver.dob
  json.address @driver.address
  json.phone @driver.phone
  json.std_code @driver.std_code
end

service_location = @driver.service_location
json.service_location do
  json.vehicle service_location&.vehicle
  json.address service_location&.address
  json.street service_location&.street
  json.state service_location&.state
  json.country service_location&.country
  json.latititude service_location&.latitude
  json.longitude service_location&.longitude
end

json.documents @driver.documents do |document|
  json.name document&.name
  json.front_url document&.front_url
  json.back_url document&. back_url
end
