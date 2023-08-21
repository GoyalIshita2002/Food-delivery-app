json.status do
  json.code "200" 
end

json.dish do
  json.partial! 'dish', locals: { dish: @dish, restaurant: @restaurant }
end