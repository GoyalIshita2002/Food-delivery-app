class RevenueService < ApplicationService
    def initialize(driver_id, start_date, end_date)
      @driver_id = driver_id
      @start_date = start_date.present? ? Date.parse(start_date) : Date.today
      @end_date = end_date.present? ? Date.parse(end_date) : Date.today
    end
  
    def generate_revenue_data
      order_ids = OrderAgent.where(driver_id: @driver_id).pluck(:order_id)
      orders = Order.where(id: order_ids)
      if orders.present?
        filtered_orders = orders.where(created_at: @start_date.beginning_of_day..@end_date.end_of_day)
        orders_by_day = filtered_orders.group_by { |order| order.created_at.strftime('%A') }
        days_of_week = Date::DAYNAMES.map(&:freeze) 
        graph_data = days_of_week.map do |day_of_week|
          orders_for_day = orders_by_day[day_of_week] || []
          {
            day: day_of_week, 
            revenue: orders_for_day.sum { |order| order.cart.total_amount }
          }
        end
        total_revenue = filtered_orders.sum { |order| order.cart.total_amount }
        { orders: filtered_orders, graph_data: graph_data, total_revenue: total_revenue }
      else
        days_of_week = Date::DAYNAMES.map(&:freeze)
        graph_data = days_of_week.map do |day_of_week|
          {
            day: day_of_week,
            revenue: 0
          }
        end
        { orders: [], graph_data: graph_data, total_revenue: 0 }
      end
    end
  end
  