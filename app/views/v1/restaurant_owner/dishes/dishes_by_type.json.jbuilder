json.status do
  json.code "200" 
end

json.data do
  json.array! @dish_types do |dish_type|
    json.title dish_type.title
    json.data do |json| 
        json.partial! 'dishes', locals: { dishes: dish_type.dishes, restaurant: @restaurant }
    end 
  end
end