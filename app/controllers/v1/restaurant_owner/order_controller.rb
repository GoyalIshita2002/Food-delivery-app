class V1::RestaurantOwner::OrderController < ApplicationController 
  
  def accept_order 
    @order = current_restaurant.orders.find(params[:order_id])
    if @order.present?
      render template: "v1/restaurant_owner/order/accept_order",status: :ok and return
    else
      render json: { status: { code: "400", errors: @order.errors.full_messages }}, status: :bad_request 
    end   
  end

  def under_preparation
    @orders_under_preparation = current_restaurant.orders.where(status: :under_preparation)
    if @orders_under_preparation.present?
      render template: "v1/restaurant_owner/order/under_preparation",status: :ok and return
    else
      render json: { status: { code: "400", errors: "No orders under preparation or ready to pick." }}, status: :bad_request 
    end 
  end

  def prepared
    @orders_prepared = current_restaurant.orders.where(status: :ready_to_pick)
    if @orders_prepared.present?
      render template: "v1/restaurant_owner/order/prepared",status: :ok and return
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
