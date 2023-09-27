json.status do
  json.code "200"
end

json.details do
  json.total_count @pagy.count
  json.total_pages @pagy.pages
end

json.dishes do 
   json.array! @dishes do |dish|   
      json.partial! 'v1/customer/dishes/dish', locals: {dish: dish}
   end
end 