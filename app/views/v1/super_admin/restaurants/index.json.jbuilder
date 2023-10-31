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
      json.phone restaurant.phone
      json.email admin_user.email
      total_price = restaurant&.orders&.reject { |order| order.status == "denied" }&.sum { |order| order.cart&.total_amount.to_f }
    json.total_price total_price || 0
  end 
end