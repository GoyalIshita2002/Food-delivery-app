json.status do 
 json.code "200"
end

json.add_on do 
  json.partial! 'add_on', locals: { add_on: @add_on}
end

