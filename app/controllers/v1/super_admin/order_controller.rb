class V1::SuperAdmin::OrderController < ApplicationController
  before_action :find_order, only: [:assign_driver, :accept_order]

  def placed_order
    @orders = Order.where(status: "placed")
    if @orders.present?
      render template: "v1/super_admin/order/placed_order",status: :ok and return
    else
      render json: { status: { code: "400", errors: ["No orders found with status placed."] } }, status: :bad_request
    end
  end
    
  def accept_order
    if @order.present?
      allowed_statuses = ["accepted","denied"]
      requested_status = params[:status].to_s.downcase
      if allowed_statuses.include?(requested_status)
        if @order.update(status: requested_status)
          render json: @order, status: :ok and return
        else
          render json: { status: { code: "400", errors: ["Invalid order status for acceptance."] }}, status: :bad_request
        end
      else
        render json: { status: { code: "400", errors: ["Invalid order status. Allowed values are #{allowed_statuses.join(', ')}."] }}, status: :bad_request
      end
    else
      render json: { status: { code: "404", errors: ["Order not found."] }}, status: :not_found
    end
  end

  def orders_without_agent
    @orders_without_agent = Order.left_outer_joins(:order_agent)
    if @orders_without_agent.present?
      render template: "v1/super_admin/order/order_without_agent",status: :ok and return
    else
      render json: { status: { code: "400", errors: ["No orders found without an assigned order agent."] } }, status: :bad_request
    end
  end

  def assign_driver 
    if @order.present? 
      if params[:driver_id].present?
        @order.order_agent.destroy! if @order.order_agent.present?
        @order.create_order_agent(driver_id: params[:driver_id]) 
      end
      render json: @order,status: :ok and return
    else
      render json: { status: { code: "400", errors: @order.errors.full_messages }}, status: :bad_request 
    end   
  end

  private

  def find_order
    @order = Order.find_by(id: params[:order_id])
  end

end
