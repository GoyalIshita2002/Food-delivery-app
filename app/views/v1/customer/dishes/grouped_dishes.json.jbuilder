json.status do
  json.code "200"
end

json.data do
  json.array! @data do |type, dishes|
    json.title type
    json.dishes do 
      json.array! dishes do |dish|   
          json.partial! 'dish', locals: {dish: dish}
      end
    end
  end
end