json.code "200"
json.success true

json.details do
  json.total_count @pagy.count
  json.total_pages @pagy.pages
end

json.restaurants do 
  json.array! @restaurants do |restaurant|
    admin_user = restaurant.admin_user
      json.id restaurant.id
      json.name restaurant.name
      json.owner_name admin_user.user_name
      json.phone admin_user.phone
      json.email admin_user.email
  end 
end