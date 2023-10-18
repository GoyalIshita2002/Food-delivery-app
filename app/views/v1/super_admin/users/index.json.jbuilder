json.code "200"
json.success true

json.details do
  json.total_count @pagy.count
  json.total_pages @pagy.pages
end

json.users do 
  json.array! @users do |user|
    json.image user.avatar_url
    json.name user.user_name
    json.email user.email
    json.phone user.phone
    user.restaurant&.orders&.each do |order| 
      @total_orders ||= 0
      @total_orders += order&.cart&.total_amount.to_f
    end
    json.total_orders @total_orders
  end  
end