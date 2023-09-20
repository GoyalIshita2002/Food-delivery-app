json.addresses current_customer.addresses do |address|
  json.partial! 'address', locals: { address: address}
end