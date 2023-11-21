class V1::SuperAdmin::OrdersController < ApplicationController
  include Pagy::Backend
  before_action :order, only: [:assign_driver, :accept_order]

  def placed_order
    @orders = Order.where(status: :pending)
    if @orders.present?
    else
      render json: { status: { code: "400", orders: [] } }, status: :ok 
    end
  end

  def index
    orders = if params[:search].present?
      search = params[:search].downcase
      Order.joins(:customer, :restaurant)
        .where(
          'lower(customers.username) LIKE :search OR lower(restaurants.name) LIKE :search OR lower(CAST(orders.id AS TEXT)) LIKE :search',
          search: "%#{search}%"
        )
    else
      Order.all
    end
    @pagy, @orders = pagy(orders, items: params[:per_page]&.to_i)
  end
   
  def accept_order
    if @order.present?
      allowed_statuses = [:admin_accepted,:admin_cancelled]
      requested_status = params[:status].to_s.downcase.to_sym
      if allowed_statuses.include?(requested_status)
        if @order.update(status: requested_status)
          render json: @order, status: :ok 
        else
          render json: { status: { code: "400", errors: ["Invalid order status for acceptance."] }}, status: :bad_request
        end
      else
        render json: { status: { code: "400", errors: ["Invalid order status. Allowed values are #{allowed_statuses.join(', ')}."] }}, status: :bad_request
      end
    else
      render json: { status: { code: "404", orders: [] }}, status: :ok 
    end
  end

  def orders_without_agent
    @orders_without_agent = Order.left_outer_joins(:order_agent)
    if @orders_without_agent.present?
    else
      render json: { status: { code: "400", orders: [] } }, status: :ok
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
      render json: { status: { code: "400", orders: [] }}, status: :ok  
    end   
  end

  def order_status
    @restaurant = Restaurant.find_by(id: params[:restaurant_id])
    if @restaurant.present?
      accepted_statuses = [:restaurant_accepted,:driver_picked_up, :delivered]
      requested_status = params[:status].to_sym
      if accepted_statuses.include?(requested_status)
        @orders = @restaurant.orders.where(status: requested_status)
        unless @orders.present?
          render json: { orders: [] }, status: :ok
        end        
      else
        render json: { status: { code: "400", errors: ["Invalid order status. Allowed values are #{accepted_statuses.join(', ')}."] } }, status: :bad_request
      end
    else
      render json: { status: { code: "400", errors: ["Restaurant not found with the provided ID"] } }, status: :bad_request
    end
  end

  def order_statistics
    placed_orders = Order.where(status: :pending).count
    ongoing_orders = Order.where(status: [:admin_accepted, :restaurant_accepted,:ready_to_pick, :driver_picked_up]).count
    orders_completed = Order.where(status: :delivered).count
    merchant_opened = Restaurant.where(open_for_orders: true).joins(:orders).count
    render json: { placed_orders: placed_orders, ongoing_orders: ongoing_orders, orders_completed: orders_completed, merchant_opened: merchant_opened }, status: :ok
  end
  

  def placed_orders_by_hours
    placed_orders_by_hour = Order.where(status: :pending).group("EXTRACT(HOUR FROM created_at AT TIME ZONE 'UTC' AT TIME ZONE 'Europe/Paris')").count
    if placed_orders_by_hour.present?
      sorted_orders_by_hour = placed_orders_by_hour.sort.to_h
      render json: { placed_orders_by_hour: sorted_orders_by_hour }, status: :ok
    else
      render json: { placed_orders_by_hour: []}, status: :ok
    end
  end
  

  def orders_ongoing_stats
    ongoing_orders = Order.where(status: [:admin_accepted , :ready_to_pick, :restaurant_accepted, :driver_picked_up])
    if ongoing_orders.present?
      ready_to_pick = ongoing_orders.where(status: :ready_to_pick).count
      on_the_way = ongoing_orders.where(status: :driver_picked_up).count
      accepted_by_merchant = ongoing_orders.where(status: :restaurant_accepted).count
      render json: { ready_to_pick: ready_to_pick, accepted_by_merchant: accepted_by_merchant, on_the_way: on_the_way }, status: :ok
    else
      render json: { ongoing_orders: 0 }, status: :ok
    end
  end
  
  def orders_unfilled_stats 
    cancelled = Order.where(status: :admin_cancelled).count
    rejected_by_merchant = Order.where(status: :restaurant_cancelled).count
    expired_by_merchant = Order.where(status: :restaurant_accepted).where("time AT TIME ZONE 'UTC' AT TIME ZONE 'Europe/Paris' < CURRENT_TIMESTAMP").count
    render json: { cancelled: cancelled, rejected_by_merchant: rejected_by_merchant, expired_by_merchant: expired_by_merchant }, status: :ok
  end
  
  
  private

  def order
    @order ||= Order.find_by(id: params[:order_id])
  end

end
