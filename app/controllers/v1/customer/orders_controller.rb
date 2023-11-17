class V1::Customer::OrdersController < ApplicationController
    
  def create
    result = Customer::OrderCreationService.call(current_customer, order_params, params[:content])
    render json: result, status: (result[:status][:code] == "200" ? :ok : :bad_request)
  end

  def denied
    order = current_customer.orders.find_by(id: params[:order_id])
    if order
      if order.update(status: :customer_denied)
        render json: { status: { code: "200", message: "Order cancelled successfully" } }, status: :ok
      else
        render json: { status: { code: "400", errors: order.errors.full_messages } }, status: :bad_request
      end
    else
      render json: { status: { code: "404", message: "Order not found" } }, status: :not_found
    end
  end
  
  def order_history
    status = params[:status]&.downcase
    case status
    when 'ongoing'
      @orders = current_customer.orders.where(status: [:pending, :admin_accepted, :restaurant_accepted, :ready_to_pick, :driver_picked_up])
    when 'past'
      @orders = current_customer.orders.where(status: [:delivered, :admin_cancelled, :restaurant_cancelled, :expired_at_restaurant, :customer_denied])
    else
      valid_statuses = ['ongoing', 'past']
      render json: { status: { code: "400", errors: ["Invalid status. Accepted values are: #{valid_statuses.join(', ')}"] } }, status: :bad_request
      return
    end
  end
  
  def index
     orders = current_customer.orders
    if orders.present?
      render json: orders, status: :ok
    else
      render json: { status: { code: "400", errors: orders.errors.full_messages }}, status: :bad_request
    end
  end

  def show
    order = current_customer.orders.find_by(id: params[:order_id])
    if order.present?
      render json: order, status: :ok
    else
      render json: { status: { code: "400", errors: order.errors.full_messages }}, status: :bad_request
    end 
  end

  def customer_feedback
    @order = current_customer.orders.find_by(id: params[:order_id])
    if @order.nil?
      render json: { status: { code: "404", errors: ["Order not found"] } }, status: :not_found
      return
    end
    feedback = @order.customer_feedbacks.create!(feedback_params)
    render json: feedback , status: :ok
  rescue ActiveRecord::RecordInvalid => e
    render json: { status: { code: "400", errors: e.record.errors.full_messages } }, status: :bad_request
  end

  
  private 

  def order_params
  params.require(:order).permit(:cart_id, :restaurant_id, :customer_address_id, :status,:driver_id).merge(customer_id: current_customer.id)
  end

  def feedback_params
    params.permit(:title, :description).merge(order_id: params[:order_id], status: @order&.status)
  end  
  
end
