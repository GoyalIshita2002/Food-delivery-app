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
      json.phone admin_user&.phone
      json.email admin_user&.email
      restaurant.orders&.each do |order|
        @total_amount ||= 0
        @total_amount += order.cart.total_amount
      end
      json.total_earning @total_amount
  end 
end