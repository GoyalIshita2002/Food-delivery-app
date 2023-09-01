json.status do 
 json.code "200"
 json.message "User verified successfully"
end

json.partial! 'v1/customer/profile'
