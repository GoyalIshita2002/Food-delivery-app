dish = item.itemable
dish_type = dish.class.to_s
json.id item.id
json.item_name dish.name
json.dish_id dish.id
json.item_type (dish_type == 'Dish') ? 'Dish' : 'AddOnItem'
json.item_image_url (dish_type == 'Dish') ? dish.image_url : ''
json.unit_price item.unit_price
json.item_quantity item.quantity 
json.item_price item.ordered_price
json.favourite (dish_type == 'Dish') ? current_customer.is_favourite_dish(dish.id) : false
json.restaurant_id (dish_type == 'Dish') ? dish.restaurant&.id : dish.dish_add_on.restaurant.id