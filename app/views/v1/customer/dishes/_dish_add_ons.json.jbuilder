json.add_ons do
  json.array! dish.dish_add_ons.uniq do |add_on|
    json.id add_on.id
    json.name add_on.name
    json.add_on_items do 
      json.array! add_on.items do |item|
        json.id item.id
        json.name item.name
        json.price item.customer_price
        json.min_quantity item.min_quantity
        json.max_quantity item.max_quantity
      end
    end
  end
end