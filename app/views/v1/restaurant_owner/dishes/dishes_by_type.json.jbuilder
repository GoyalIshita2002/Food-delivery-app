json.status do
  json.code "200" 
end

json.data do
  @dish_types.each do |dish_type|
    json.set! dish_type.title  do |json| 
        json.partial! 'dishes', locals: { dishes: dish_type.dishes, restaurant: @restaurant }
    end 
  end
end