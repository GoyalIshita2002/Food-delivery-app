json.admin_user do 
 json.user_name current_admin_user.user_name
 json.email current_admin_user.email
end

json.restaurant do 
 json.id @restaurant.id
 json.name @restaurant.name
 json.type @restaurant.categories.pluck(:name)
 json.address @restaurant.address
 json.coordinates @restaurant.coordinates
 json.open_hours @restaurant.working_hours
end

