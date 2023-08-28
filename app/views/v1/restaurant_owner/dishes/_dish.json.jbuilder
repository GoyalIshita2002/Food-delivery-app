

json.id dish.id
json.name dish.name
json.image_url dish.image_url
json.price dish.price
json.descripton dish.descripton
json.is_popular dish.is_popular
json.is_available dish.is_available
json.dish_type do
  json.partial! 'dish_type', locals: { dish_type: dish.dish_type }
end
json.restaurant do
  json.id restaurant.id
  json.name restaurant.name
end
 