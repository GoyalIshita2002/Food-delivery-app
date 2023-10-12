json.status do 
    json.code "200"
    json.message "signin successful"
end

json.driver do
  json.id @driver.id
  json.phone @driver.phone
  json.std_code @driver.std_code
end 

if @driver.service_location.present?
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
end

if @driver.avatar_url.present? || @driver.full_name.present? || @driver.email.present? || @driver.dob.present? || @driver.address.present?
  json.profile_info do
    json.image @driver.avatar_url
    json.name @driver.full_name
    json.email @driver.email
    json.dob @driver.dob
    json.address @driver.address
  end
end

if @driver.documents.present?
  json.documents @driver.documents do |document|
      json.name document&.name
      json.front_url document&.front_url
      json.back_url document&. back_url
  end
end

json.auth_token @driver.generate_jwt