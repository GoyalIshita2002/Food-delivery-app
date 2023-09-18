json.status do
 json.code "200"
 json.message "Restaurant created successfully"
end

restaurant = @admin.restaurant


json.partial! 'restaurant', locals: { restaurant: restaurant}