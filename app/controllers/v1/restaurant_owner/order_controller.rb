class V1::RestaurantOwner::OrderController < ApplicationController 
  before_action :validate_order, only: :update

  def accept_order  
    @order = current_restaurant.orders.find(params[:order_id])
    if @order.present?
      render template: "v1/restaurant_owner/order/accept_order",status: :ok and return
    else
      render json: { status: { code: "400", errors: @order.errors.full_messages }}, status: :bad_request 
    end   
  end

  def index
    @orders = unless params[:status].present?
       current_restaurant.orders
    else
      status = params[:status].is_a?(Array) ? params[:status].map(&:to_sym) : params[:status]
      current_restaurant.orders.where(status: status)
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
    if order.update(permitted_params)
      render json: order, status: :ok
    else
      render json: { status: { code: "400", errors: order.errors.full_messages }}, status: :bad_request
    end
  end
  
  private

  def permitted_params
   params = params.permit(:status,:time)
   params[:time] = Time.now + params[:time].to_i.minutes if params[:time].present?
   params
  end

  def current_restaurant
    current_admin_user.restaurant
  end

  def validate_order
    unless current_restaurant.present?
      render json: {status: { code: "404", error: "No associated restaurant was found under current admin"}},status: :not_found and return
    end
    unless order.present?
      render json: {status: { code: "400", error: "Invalid/unauthorized order ID"}},status: :bad_request and return
    end
    if params[:status].present? && Order::RESTAURANT_STATUSES.include?(params[:status].to_sym)
      unless [1,2].include?(Order.statuses[order.status])
        render json: {status: { code: "422", error: "Current order status restricts requested update"}},status: :unprocessable_entity and return
      end
    end
  end

  def order
    @order ||= current_restaurant.orders.find_by(id: params[:order_id])
  end
end
