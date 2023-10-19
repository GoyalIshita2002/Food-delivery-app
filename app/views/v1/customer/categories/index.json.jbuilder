json.code "200"
json.success true

json.categories do 
  json.array! @categories do |category|
   json.id category.id
   json.title category.title
   json.image_url category.image_url
  end
end