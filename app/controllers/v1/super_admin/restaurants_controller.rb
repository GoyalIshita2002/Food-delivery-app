class V1::SuperAdmin::RestaurantsController < ApplicationController

  def create
    @admin = SuperAdmin::CreateRestaurant.call(restaurant_admin_params)
    unless @admin.persisted?
      render json: { status: { code: "400", message: "Failed to create Restaurant" }},status: :bad_request and return  
    end
  end

  def update
  end

  def show
  end

  protected

  def restaurant_admin_params
    params.require(:restaurant_admin).permit(:email,:user_name, :password, :phone, :restaurant => {})
  end
end
