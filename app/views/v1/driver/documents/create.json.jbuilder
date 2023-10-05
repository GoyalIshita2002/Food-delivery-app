json.status do 
  json.code "200"
  json.message "document create successful"
end
json.documents do
  json.id @document.id
  json.name @document.name
  json.front_url @document.front_url
  json.back_url @document.back_url
end