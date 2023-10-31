json.status do
  json.code "200"
end

json.orders do
  json.array! @restaurant_files do |files|
    json.id files.id
    json.name files.name
  end
end



