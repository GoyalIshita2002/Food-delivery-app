

json.id dish.id
json.name dish.name
json.image_url dish.image_url
json.price dish.price
json.descripton dish.description
json.is_popular dish.is_popular
json.is_available dish.is_available
json.dish_type do
  json.partial! 'dish_type', locals: { dish_type: dish.dish_type }
end

json.add_ons do 
  add_ons = dish.dish_add_ons.uniq
  json.array! add_ons do |add_on|
    json.partial! 'add_on', locals: { add_on: add_on, dish: dish}
  end
end

json.restaurant do
  json.id restaurant.id
  json.name restaurant.name
end
 