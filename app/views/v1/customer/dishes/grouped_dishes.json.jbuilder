json.status do
  json.code "200"
end

json.data do
  json.array! @data do |type, dishes|
    json.title type
    json.dishes do 
      json.array! dishes do |dish|   
          json.id dish.id
          json.image_url dish.image_url
          json.name dish.name
          json.price dish.price&.to_f
      end
    end
  end
end