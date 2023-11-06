class SuperAdmin::UpdateRestaurant < ApplicationService

  def initialize(params, restaurant)
    @params = params
    @restaurant = restaurant
  end
  
  attr_reader :params

  def call
    ActiveRecord::Base.transaction do 
      @restaurant.update(restaurant_params) 
      @restaurant.restaurant_address.update(restaurant_address_params) if restaurant_address_params.present?
      open_hour_params.each do |open_params|
        open_hour = @restaurant.open_hours.find_by(id: open_params[:id])
        open_hour&.update(open_params.except(:split_hours))
        open_hour&.split_hours.find_by(id: params[:id])&.update(open_params['split_hour'])
      end
      @restaurant.customer_margin.update(margin_percent: customer_margin) if customer_margin.present?
      @restaurant.restaurant_margin.update(margin_percent: restaurant_margin) if restaurant_margin.present?
    end
  end

  def restaurant_params 
    params.require(:restaurant).permit(:name, :registration_date, :phone, :lock_menu, :main_image)
  end

  def restaurant_address_params
    if params[:restaurant].present? && params[:restaurant][:restaurant_address].present?
      params.require(:restaurant).require(:restaurant_address).permit(:address1, :address2, :street, :city, :state, :zip_code, :state_code)
    end
  end

  def open_hour_params
    if params[:restaurant].present? && params[:restaurant][:open_hours].present?
      params.require(:restaurant).require(:open_hours)
    end
  end

  def margins
    if params[:restaurant].present? && params[:restaurant][:margins].present?
      params.require(:restaurant).require(:margins).permit(:id, :customer_percent, :restaurant_percent)
    end
  end

  def customer_margin
    margins[:customer_percent]
  end

  def restaurant_margin
    margins[:restaurant_percent]
  end

end