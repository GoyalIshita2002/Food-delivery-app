json.code "200"
json.success true
json.details do
  json.total_count @pagy.count
  json.total_pages @pagy.pages
end
json.customer_users do
  json.array! @customer_users do |customer_user|
    json.id customer_user.id
    json.image customer_user.avatar_url
    json.name customer_user.username
    json.email customer_user.email
    json.phone customer_user.phone
    customer_user&.orders&.each do |order|
      @total_orders ||= 0
      @total_orders += order&.cart&.total_amount.to_f
    end
    json.total_orders @total_orders
  end
end