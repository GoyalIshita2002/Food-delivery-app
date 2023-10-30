class V1::SuperAdmin::OrderController < ApplicationController
  before_action :find_order, only: [:assign_driver, :accept_order]

  def placed_order
    @orders = Order.where(status: :placed)
    if @orders.present?
      render template: "v1/super_admin/order/placed_order",status: :ok and return
    else
      render json: { status: { code: "400", errors: ["No orders found with status placed."] } }, status: :bad_request
    end
  end
    
  def accept_order
    if @order.present?
      allowed_statuses = [:accepted,:denied]
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

  def order_status
    @restaurant = Restaurant.find_by(id: params[:restaurant_id])
    if @restaurant.present?
      accepted_statuses = [:under_preparation, :in_transit, :ready_to_pick]
      requested_status = params[:status].to_sym
      if accepted_statuses.include?(requested_status)
        @orders = @restaurant.orders.where(status: requested_status)
        if @orders.present?
          render template: "v1/super_admin/order/order_status", status: :ok
        else
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
    placed_orders = Order.where(status: :placed).count
    ongoing_orders = Order.where(status: [:accepted, :under_preparation, :ready_to_pick, :in_transit, :assigning]).count
    orders_completed = Order.where(status: :delivered).count
    merchant_opened = Restaurant.where(open_for_orders: true).joins(:orders).count
    render json: { placed_orders: placed_orders, ongoing_orders: ongoing_orders, orders_completed: orders_completed, merchant_opened: merchant_opened }, status: :ok
  end
  

  def placed_orders_by_hours
    placed_orders_by_hour = Order.where(status: :placed).group("EXTRACT(HOUR FROM created_at AT TIME ZONE 'UTC' AT TIME ZONE 'Europe/Paris')").count
    if placed_orders_by_hour.present?
      sorted_orders_by_hour = placed_orders_by_hour.sort.to_h
      render json: { placed_orders_by_hour: sorted_orders_by_hour }, status: :ok
    else
      render json: { orders: 0 }, status: :ok
    end
  end
  

  def orders_ongoing_stats
    ongoing_orders = Order.where(status: [:accepted, :under_preparation, :ready_to_pick, :in_transit, :assigning])
    if ongoing_orders.present?
      ready_to_pick = ongoing_orders.where(status: :ready_to_pick).count
      on_the_way = ongoing_orders.where(status: :in_transit).count
      assigning = ongoing_orders.where(status: :assign_driver).count
      accepted_by_merchant = ongoing_orders.where(status: :accepted).count
      render json: { ready_to_pick: ready_to_pick, assigning: assigning, accepted_by_merchant: accepted_by_merchant, on_the_way: on_the_way }, status: :ok
    else
      render json: { ongoing_orders: 0 }, status: :ok
    end
  end
  
  def orders_unfilled_stats 
    cancelled = Order.where(status: :cancelled).count
    rejected_by_merchant = Order.where(status: :denied).count
    expired_by_merchant = Order.where(status: :accepted).where("time AT TIME ZONE 'UTC' AT TIME ZONE 'Europe/Paris' < CURRENT_TIMESTAMP").count
    render json: { cancelled: cancelled, rejected_by_merchant: rejected_by_merchant, expired_by_merchant: expired_by_merchant }, status: :ok
  end
  
  
  private

  def find_order
    @order = Order.find_by(id: params[:order_id])
  end

end
