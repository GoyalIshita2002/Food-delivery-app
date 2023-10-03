json.status do 
 json.code "200"
 json.message  I18n.t('session.signin.success')
end

json.partial! 'v1/customer/profile'


json.auth_token current_customer.generate_jwt