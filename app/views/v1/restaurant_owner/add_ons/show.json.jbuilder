json.status do 
 json.code "200"
end

json.partial! 'add_on', locals: { add_on: @add_on}