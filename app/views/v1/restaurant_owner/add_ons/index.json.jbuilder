json.status do 
 json.code "200"
end

json.add_ons do 
  json.array! @add_ons do |add_on|
    json.partial! 'add_on', locals: { add_on: add_on}
  end
end