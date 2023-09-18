class V1::AdminUsers::RestaurantsController < ApplicationController
  

  def details
    unless current_admin_user.present?
      render json: { status: "401", message: "Authorization failure" }, status: :unauthorized and return 
    end

    @restaurant = current_admin_user.restaurant
  end


end
