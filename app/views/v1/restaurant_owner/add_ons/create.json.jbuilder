json.status do 
  json.code "200"
  json.message "AddOn created successfully"
end

json.partial! 'add_on', locals: { add_on: @add_on}
