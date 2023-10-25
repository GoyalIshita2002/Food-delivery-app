
json.partial! 'restaurant', locals: { restaurant: @restaurant}

json.documents do
  debugger
  json.array! Document.where(id:@restaurant.id) do |document|
    json.partial! 'v1/super_admin/documents/document', locals: { document: document}
  end
end
