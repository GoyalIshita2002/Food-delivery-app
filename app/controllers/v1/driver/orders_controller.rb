class V1::Driver::OrdersController < ApplicationController

 def update
  orders = Order.find_by(id: params[:order_id])
   if orders.present?
    allowed_statuses = [:driver_picked_up,:delivered]
    requested_status = params[:status].to_s.downcase.to_sym
    if allowed_statuses.include?(requested_status)
      if orders.update(status: requested_status)
        render json: orders, status: :ok 
      else
        render json: { status: { code: "400", errors: ["Invalid order status for acceptance."] }}, status: :bad_request
      end
    else
      render json: { status: { code: "400", errors: ["Invalid order status. Allowed values are #{allowed_statuses.join(', ')}."] }}, status: :bad_request
    end
   else
    render json: { status: { code: "400", errors: orders.errors.full_messages }}, status: :bad_request
   end
 end
 
  def index
    if params[:driver_id].present?
    order_ids = OrderAgent.where(driver_id: params[:driver_id]).pluck(:order_id)
    @orders = Order.includes(:customer, :customer_address,:customer,:cart).where(id: order_ids)
    else
      render json: { status: { code: "400", orders: [] } }, status: :ok
    end
  end
  
end
