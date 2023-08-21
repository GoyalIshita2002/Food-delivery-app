json.status do
  json.code "200" 
  json.message "Dish updated successfully"
end

json.dish do
  json.partial! 'dish', locals: { dish: @dish, restaurant: @restaurant }
end 