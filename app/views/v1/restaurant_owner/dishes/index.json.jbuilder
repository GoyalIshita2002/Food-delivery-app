json.status do
  json.code "200" 
end

json.data @dishes do |dish|
  json.partial! 'dish', locals: { dish: dish, restaurant: @restaurant }
end