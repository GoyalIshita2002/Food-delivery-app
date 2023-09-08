json.status do
 json.code "200"
 json.message "Restaurant created successfully"
end

restaurant = @admin.restaurants.last


json.partial! 'restaurant', locals: { restaurant: restaurant}