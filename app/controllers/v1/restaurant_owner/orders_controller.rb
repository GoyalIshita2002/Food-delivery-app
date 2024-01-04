class V1::RestaurantOwner::OrdersController < ApplicationController 
  before_action :validate_order, only: :update

  def show  
    unless order.present?
      render json: {status: { code: "400", error: "Invalid/unauthorized order ID"}},status: :bad_request and return
    end
  end

  def index
    @orders = unless params[:status].present?
       current_restaurant.orders
    else
      status = params[:status].is_a?(Array) ? params[:status].map(&:to_sym) : params[:status]
      current_restaurant.orders.where(status: status)
    end
    if params[:duration].present? && ["weekly","monthly","total"].include?(params[:duration])
      @orders = if ["weekly","monthly"].include?(params[:duration])
        @orders.where(status: :delivered).filter_by_duration(params[:duration])
      else
        @orders.where(status: :delivered)
      end
    end
  end  
  
  def update 
    if order.update(update_params)
      render json: order, status: :ok
    else
      render json: { status: { code: "400", errors: order.errors.full_messages }}, status: :bad_request
    end
  end
  
  private

  def permitted_params
    params.permit(:status,:time)
  end

  def update_params
    if permitted_params[:time].present?
      time = Time.now + permitted_params[:time].to_i.minutes 
      permitted_params.merge(time: time)
    else
      permitted_params
    end
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
    if permitted_params[:status].present? && Order::RESTAURANT_STATUSES.include?(permitted_params[:status].to_sym)
      unless [1,2].include?(Order.statuses[order.status])
        render json: {status: { code: "422", error: "Current order status restricts requested update"}},status: :unprocessable_entity and return
      end
    end
  end

  def order
    @order ||= current_restaurant.orders.find_by(id: params[:order_id])
  end
end
