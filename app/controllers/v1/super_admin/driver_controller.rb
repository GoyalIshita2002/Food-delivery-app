class V1::SuperAdmin::DriverController < ApplicationController
  include Pagy::Backend

  def index
    driver = if params[:search].present?
      search = params[:search].downcase
      Driver.where('lower(email) LIKE ?', "%#{search}%")
        .or(Driver.where('lower(full_name) LIKE ?', "%#{search}%"))
        .or(Driver.where('lower(phone) LIKE ?', "%#{search}%"))
    else
      Driver.all
    end
    @pagy, @driver = pagy(driver, items: params[:per_page]&.to_i)
  end

  def driver_order_list
    driver = Driver.find_by(id: params[:driver_id]) 
    if driver.present?
      order_ids = OrderAgent.where(driver_id: driver.id).pluck(:order_id)
      @orders = Order.where(id: order_ids)
      unless @orders.present?
        render json: { orders: [] }, status: :ok
      end
    else
      render json: { error: 'Driver not found with the provided ID' }, status: :unprocessable_entity
    end
  end

  def revenue_by_day
    driver_id = params[:driver_id].to_i
    start_date = params[:start_date]
    end_date = params[:end_date]
    service = RevenueService.new(driver_id, start_date, end_date)
    result = service.generate_revenue_data
    render json: result, status: :ok
  end
  
  def upsert
    min_distance = params[:min_distance].to_f
    max_distance = params[:max_distance].to_f
    charge = params[:charge].to_i
    delivery_charge =  DeliveryCharge.upsert(min_distance, max_distance, charge)
    if delivery_charge.present?
      render json: delivery_charge,status: :ok and return
    else
      render json: { status: {code: "400", error: delivery_charge.errors.full_message }}, status: :bad_request and return
    end
  end
  
end
