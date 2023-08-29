json.id add_on.id
json.name add_on.name
json.items do
  items = dish.items.where(dish_add_on_id: add_on.id)
  json.array! items do |item| 
      json.partial! 'item', locals: { item: item }
  end
end