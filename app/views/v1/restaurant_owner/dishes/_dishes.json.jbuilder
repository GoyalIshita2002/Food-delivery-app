
json.array! dishes do |dish|
  json.partial! 'dish', locals: { dish: dish, restaurant: @restaurant }
end