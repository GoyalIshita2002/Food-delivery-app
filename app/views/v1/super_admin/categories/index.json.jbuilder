json.code "200"
json.success true

json.users do 
  json.array! @dish_types do |dish_type|
   json.id dish_type.id
   json.title dish_type.title
   json.image_url nil
  end
end