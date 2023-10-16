json.status do
  json.code "200"
  json.message " profile update successful"
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