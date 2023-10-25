class V1::RestaurantOwner::DashboardsController < ApplicationController
  
  def analysts
   @orders=current_restaurant.orders.where(updated_at: Time.zone.yesterday.end_of_day.in_time_zone('CET')..Time.zone.today.end_of_day.in_time_zone('CET'))
   @completed_orders=current_restaurant.orders.where(updated_at: Time.zone.yesterday.end_of_day.in_time_zone('CET')..Time.zone.today.end_of_day.in_time_zone('CET'),status:6)
   @ongoing_orders=current_restaurant.orders.where(updated_at: Time.zone.yesterday.end_of_day.in_time_zone('CET')..Time.zone.today.end_of_day.in_time_zone('CET'),status:[accepted:1,under_preparation:3,ready_to_pick:4,in_transit:5])
  end
  
  def weekly_update
    @sun=calculate_earning(0)
    @mon=calculate_earning(1)
    @tues=calculate_earning(2)
    @wed=calculate_earning(3)
    @thurs=calculate_earning(4)
    @fri=calculate_earning(5)
    @sat=calculate_earning(6)
  end

  def total_earning
    orders= current_restaurant.orders.where(updated_at: Date.today.beginning_of_week.in_time_zone('CET')..Date.today.end_of_week.in_time_zone('CET'))
    @sum = 0
    orders&.each do |order|
     @sum += order.cart.total_amount
    end
    @sum
  end

  def earnings_by_day(day)
     orders=current_restaurant.orders.where("EXTRACT(dow FROM updated_at) = ?", day)
     @sum = 0
     orders&.each do |order|
       @sum += order.cart.total_amount
     end
    @sum
  end

  def calculate_earning(day)
    @earning=earnings_by_day(day)
    unless total_earning.zero? && @earning == 0
      (( @earning/total_earning)*100).round(3).to_f
    end
  end

  def current_restaurant
   current_admin_user.restaurant
  end
end
 