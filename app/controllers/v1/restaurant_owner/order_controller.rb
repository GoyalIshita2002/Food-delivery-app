class V1::RestaurantOwner::OrderController < ApplicationController 
  
  def accept_order 
    @order = current_restaurant.orders.find(params[:order_id])
    if @order.present?
      render template: "v1/restaurant_owner/order/accept_order",status: :ok and return
    else
      render json: { status: { code: "400", errors: @order.errors.full_messages }}, status: :bad_request 
    end   
  end

  def prepared
    accepted_statuses = [:restaurant_accepted, :ready_to_pick]
    status_param = params[:status].to_sym
    unless accepted_statuses.include?(status_param)
      render json: { status: { code: "400", errors: "Invalid status parameter." }}, status: :bad_request and return
    end
    @orders = current_restaurant.orders.where(status: status_param)
    if @orders.present?
      render template: "v1/restaurant_owner/order/prepared", status: :ok and return
    else
      render json: { status: { code: "400", errors: "No orders under preparation or ready to pick." }}, status: :bad_request 
    end
  end
  

  def update
    order = current_restaurant.orders.find(params[:order_id])
    new_time = Time.now + params[:time].to_i.minutes
    if order.update(status: params[:status], time: new_time)
      render json: order, status: :ok
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
