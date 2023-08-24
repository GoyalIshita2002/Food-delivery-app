class SuperAdmin::CreateRestaurant < ApplicationService

  def initialize(params)
    @params = params
  end
  
  attr_reader :params

  def call
    admin = ActiveRecord::Base.transaction do 
              admin = AdminUser.create!(restaurant_admin_params)
              restaurant = admin.restaurants.create(restaurant_params) 
              restaurant.create_restaurant_address(restaurant_address_params)
              open_hour_params.each do |open_params|
                open_hour = restaurant.open_hours.create(open_params.except(:split_hours))
                open_params[:split_hours].each do |split_hour|
                  open_hour.split_hours.create(split_hour)
                end
              end
              admin
            end
  end

  def restaurant_admin_params
    params.permit(:email,:user_name,:password)
  end

  def restaurant_params 
    params.require(:restaurant).permit(:name, :registration_date, :phone)
  end

  def restaurant_address_params
    params.require(:restaurant).require(:restaurant_address).permit(:address1, :address2, :street, :city, :state, :zip_code)
  end

  def open_hour_params
    # params.require(:restaurant).require(:open_hours).permit([:day, :start_time, :end_time, :split_hours_attributes => []])
    params.require(:restaurant).require(:open_hours)
  end

end