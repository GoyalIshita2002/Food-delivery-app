json.profiles do
  json.array! @drivers do |driver|
    json.id driver.id
    json.image driver.avatar_url
    json.name driver.full_name
    json.email driver.email
    json.dob driver.dob
    json.address driver.address
  end
end   