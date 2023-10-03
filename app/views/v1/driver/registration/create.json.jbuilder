json.status do 
    json.code "200"
    json.message "signup successful"
end

json.driver do
  json.id @driver.id
  json.phone @driver.phone
  json.std_code @driver.std_code
end  

json.auth_token @driver.generate_jwt