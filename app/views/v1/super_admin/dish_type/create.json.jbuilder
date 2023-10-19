json.code "200"
json.success true

json.dish_type do 
   json.id @dish_type.id
   json.title @dish_type.title
   json.image_url @dish_type.image_url
end