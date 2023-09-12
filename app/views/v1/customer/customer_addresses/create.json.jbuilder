json.status do
  json.code "200"
  json.message "Address added successfully"
end

json.addresses current_customer.addresses do |address|
  json.partial! 'address', locals: { address: address}
end


