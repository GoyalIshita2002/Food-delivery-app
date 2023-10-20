json.status do 
 json.code "200"
 json.message "signup successful"
end

json.partial! 'v1/customer/profile'
