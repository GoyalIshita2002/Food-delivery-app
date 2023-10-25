json.total_analysts do
   json.order_completed @completed_orders.count
   json.ongoing @ongoing_orders.count
    @orders&.each do |order|
    @total_prices ||= 0
    @total_prices += order.cart.total_amount
   end
   json.total_earning @total_prices.to_f
end