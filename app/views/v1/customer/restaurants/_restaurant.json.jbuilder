json.id restaurant.id
json.name restaurant.name
json.image restaurant.main_image_url
json.categories restaurant.categories.pluck(:name).join(',')
json.avg_pricing restaurant.avg_pricing&.min_price || 0 
json.avg_rating restaurant.avg_rating || 0
