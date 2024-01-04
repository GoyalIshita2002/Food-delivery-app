json.code "200"
json.success true

json.details do
  json.total_count @pagy.count
  json.total_pages @pagy.pages
end

json.restaurants do 
  json.array! @restaurants do |restaurant|
      json.partial! 'restaurant', locals: { restaurant: restaurant }
  end
end