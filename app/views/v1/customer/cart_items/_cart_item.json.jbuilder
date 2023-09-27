dish = item.dish
json.id item.id
json.item_name dish.name
json.dish_id dish.id
json.item_image_url dish.image_url
json.unit_price item.unit_price
json.item_quantity item.quantity 
json.item_price item.ordered_price
json.favourite current_customer.is_favorite_dish(dish.id)