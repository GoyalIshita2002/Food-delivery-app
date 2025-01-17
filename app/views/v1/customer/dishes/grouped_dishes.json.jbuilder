json.status do
  json.code "200"
end

json.data do
  json.array! @data do |type, dishes|
    json.title type
    json.data do 
      json.array! dishes do |dish|   
        json.partial! 'dish', locals: {dish: dish}
        json.partial! 'dish_add_ons', locals: {dish: dish}
      end
    end
  end
end