class V1::SuperAdmin::OrdersController < ApplicationController
  include Pagy::Backend
  before_action :order, only: [:assign_driver, :accept_order]

  def placed_order
    @orders = if params[:search].present?
      search = params[:search].downcase
      Order.where('lower(CAST(id AS TEXT)) = :search', search: search).where(status: :pending)
    else
      Order.where(status: :pending)
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
    @orders_without_agent = if params[:search].present?
      search = params[:search].downcase
      Order.where('lower(CAST(id AS TEXT)) = :search', search: search).where(status: :admin_accepted)
    else
      Order.left_outer_joins(:order_agent).where(status: :admin_accepted)
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
    if @restaurant
      @orders = @restaurant.orders.group_by(&:status)
    else
      render json: { status: "error", error: "Restaurant not found with the provided ID" }, status: :not_found
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

  def todays_order
    today_start = Time.zone.now.beginning_of_day
    today_end = Time.zone.now.end_of_day
    orders = Order.where(created_at: today_start..today_end)
    on_the_way = orders.where(status: [:ready_to_pick, :driver_picked_up]).count
    delivered = orders.where(status: :delivered).count
    cancelled = orders.where(status: :admin_cancelled).count
    render json: { on_the_way: on_the_way, delivered: delivered, cancelled: cancelled }, status: :ok
  end

  def revenue_stats 
    grouped_orders = {}
    if params[:start_date].present? && params[:end_date].present?
      start_date = Date.parse(params[:start_date])
      end_date = Date.parse(params[:end_date])
      Order.joins(:cart).where(created_at: start_date..end_date)
                        .pluck("carts.total_amount","orders.created_at")
                        .map{|arr| [arr[0],arr[1].strftime("%A")]}
                        .group_by{|arr| arr[1]}.each do |k,v|
                              count = 0
                              v.each do |arr|
                              count += arr[0]
                              end
                              grouped_orders[k] = count.to_f
      end
      render json: grouped_orders
    else
      render json: { status: { code: 400, message: "missing required params"}},status: :bad_request and return
    end
  end

  def update_charges
    unless params[:charges].present?
      render json: { status: {code: 400, message: "Request missing charges"}}, status: :bad_request and return
    end
    params[:charges].each do |del_charge|
      delivery_charge = DeliveryCharge.find_by(id: del_charge[:id])
      delivery_charge.update(charge: del_charge[:charge]) if delivery_charge.present?
    end
    
    render json: { status:{code:200}, data: DeliveryCharge.all },status: :ok 
  end

  def delivery_charges
    unless DeliveryCharge.exists?
      DeliveryCharge.create_default_charges
    end 
    render json: { status:{code:200}, data: DeliveryCharge.all },status: :ok 
  end
  
  private

  def order
    @order ||= Order.find_by(id: params[:order_id])
  end

end
