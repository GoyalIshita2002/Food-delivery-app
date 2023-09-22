json.status do
  json.code "200"
end

json.data do
  @data.each do |type, dishes|
    json.set! type do 
      json.array! dishes do |dish|   
          json.id dish.id
          json.image_url dish.image_url
          json.name dish.name
          json.price dish.price&.to_f
      end
    end
  end
end