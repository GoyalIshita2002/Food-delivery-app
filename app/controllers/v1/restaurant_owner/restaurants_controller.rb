class V1::RestaurantOwner::RestaurantsController < ApplicationController

  def update
    if restaurant.present?
      RestaurantOwner::UpdateRestaurant.call(restaurant, restaurant_params)
      render json: { status: { code:"200", message: "Restaurant updated successfully"}, data: restaurant.reload }
    else
      render json: { status: { code:"404", message: "Restaurant not found"} }
    end
  # rescue => e
  #   render json: { status: { code: "422", message: "Update Failed"}, errors: e.message }
  end

  def restaurant_params
    params.require(:restaurant).permit(:open_for_orders)
  end

  def restaurant_id
    request.headers["restaurant-id"]
  end

  def restaurant
    @restaurant ||= Restaurant.find_by(id: restaurant_id)
  end
end
