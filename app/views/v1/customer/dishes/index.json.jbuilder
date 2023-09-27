json.status do
  json.code "200"
end

json.dishes do 
   json.array! @dishes do |dish|   
    json.partial! 'dish', locals: {dish: dish}
   end
end