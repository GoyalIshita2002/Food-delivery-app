json.status do
  json.code "200" 
end

json.data @dish_types do |dish_type|
  json.partial! 'dish_type', locals: { dish_type: dish_type}
end