json.status do
    json.code "200"
    json.message "update successful"
  end
  
  json.partial! 'v1/customer/profile'