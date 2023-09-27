json.id dish.id
json.image_url dish.image_url
json.name dish.name
json.price dish.price&.to_f
json.is_favourite current_customer.is_favourite_dish(dish.id)