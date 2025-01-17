class V1::RestaurantOwner::ProfileController < ApplicationController
  before_action :check_current_user
  before_action :check_restaurant, only: :update

  def update
    @admin = ActiveRecord::Base.transaction do 
      current_admin_user.update(profile_params)
      RestaurantOwner::UpdateRestaurant.call(restaurant, restaurant_params) if restaurant_params.present?
      RestaurantOwner::UpdateRestaurantAddress.call(restaurant, restaurant_address_params) if restaurant_address_params.present?
      current_admin_user.reload
    end
  end

  def show
    @admin = current_admin_user
  end
 
  def upload_image 
    unless params[:avatar].present?
      render json: { status: {code:"404", message:"Missing avatar"}}, status: :bad_request
    end
    if current_admin_user.update(avatar: params[:avatar])
      @admin = current_admin_user.reload
      render template: "v1/restaurant_owner/profile/update"
    else
      render json: { code: { status: "400", errors: current_admin_user.errors&.full_messages }}, status: :bad_request and return
    end
  end

  def check_current_user
    unless current_admin_user.present?
      render json: {status: {code: "401", message: "Profile not found"}}, status: :unauthorised
    end
  end

  def profile_params
    params.require(:restaurant_admin).permit(:user_name,:email)
  end

  def restaurant_params
    params.require(:restaurant_admin).require(:restaurant).permit(:name,:phone, :std_code)
  end

  def restaurant_address_params
    params.require(:restaurant_admin).require(:restaurant).require(:restaurant_address).permit(:address1,:address2,:state,:city,:zip_code, :state_code)
  end

  def restaurant_id
    request.headers["restaurant-id"]
  end

  def restaurant
    @restaurant ||= current_admin_user.restaurant
  end

  def check_restaurant
    unless restaurant.present?
      render json: { status: { code: "404", message: "Invalid Restaurant"}}, status: :not_found
    end
  end
end
