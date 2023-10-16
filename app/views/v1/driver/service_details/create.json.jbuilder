json.status do 
  json.code "200"
  json.message "service location created succesfully"
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


