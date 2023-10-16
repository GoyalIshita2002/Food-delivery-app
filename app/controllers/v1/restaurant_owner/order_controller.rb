class V1::RestaurantOwner::OrderController < ApplicationController 
  
  def accept_order 
    @order = current_restaurant.orders.find(params[:order_id])
    if @order.present?
      render template: "v1/restaurant_owner/order/accept_order",status: :ok and return
    else
      render json: { status: { code: "400", errors: @order.errors.full_messages }}, status: :bad_request 
    end   
  end

  def update
    order = current_restaurant.orders.find(params[:order_id])
    if order.update(params_permit)
      render json: order,status: :ok and return
    else
      render json: { status: { code: "400", errors: order.errors.full_messages }}, status: :bad_request 
    end 
  end
  
  private

  def params_permit
   params.permit(:status,:time)
  end

  def current_restaurant
    current_admin_user.restaurant
  end
end
