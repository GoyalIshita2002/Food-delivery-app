json.profile_info do
  json.id @driver.id
  json.image @driver.avatar_url
  json.name @driver.full_name
  json.email @driver.email
  json.dob @driver.dob
  json.address @driver.address
end   