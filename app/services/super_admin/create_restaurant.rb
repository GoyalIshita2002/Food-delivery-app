class SuperAdmin::CreateRestaurant < ApplicationService

  def initialize(params)
    @params = params
  end
  
  attr_reader :params

  def call
    admin = ActiveRecord::Base.transaction do 
      admin = AdminUser.create!(restaurant_admin_params)
      restaurant = admin.create_restaurant(restaurant_params)
      restaurant.create_restaurant_address(restaurant_address_params)
      open_hour_params.each do |open_params|
        open_hour = restaurant.open_hours.create(open_params.except(:split_hours))
        open_params[:split_hours].each do |split_hour|
          open_hour.split_hours.create(split_hour)
        end
      end
      restaurant.create_customer_margin(margin_percent: customer_margin) if customer_margin.present?
      restaurant.create_restaurant_margin(margin_percent: restaurant_margin) if restaurant_margin.present?
      blob_id = params.dig(:restaurant, :blob_id)
      blob = ActiveStorage::Blob.find_by(id: blob_id)
      restaurant.main_image.attach(blob) if blob.present?
      admin
    end
  end

  def restaurant_admin_params
    params.permit(:email,:user_name,:password)
  end

  def restaurant_params 
    params.require(:restaurant).permit(:name, :registration_date, :phone, :lock_menu)
  end

  def restaurant_address_params
    params.require(:restaurant).require(:restaurant_address).permit(:address1, :address2, :street, :city, :state, :zip_code, :state_code)
  end

  def open_hour_params
    params.require(:restaurant).require(:open_hours)
  end

  def margins
    params.require(:restaurant).require(:margins).permit(:customer_percent, :restaurant_percent)
  end

  def customer_margin
    margins[:customer_percent]
  end

  def restaurant_margin
    margins[:restaurant_percent]
  end
end