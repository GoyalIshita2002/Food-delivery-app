
json.partial! 'restaurant', locals: { restaurant: @restaurant}

json.documents do
  json.array! @restaurant.restaurant_files do |document|
    json.partial! 'v1/super_admin/documents/document', locals: { document: document}
  end
end
