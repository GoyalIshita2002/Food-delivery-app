json.status do 
 json.code "200"
 json.message "signup successful"
end

json.partial! 'v1/customer/profile'

json.verification_otp current_customer.verification_otp
