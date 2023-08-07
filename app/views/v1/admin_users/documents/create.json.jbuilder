json.status "200"
json.message "Document uploaded succesfully"

json.restaurant do
 json.id @restaurant.id
 json.name @restaurant.name
end

json.document do 
  json.id @document.id
  json.name @document.name
  json.front_url @document.front.url
  json.back_url @document.back.url
end