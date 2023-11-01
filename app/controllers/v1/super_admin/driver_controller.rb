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

end
