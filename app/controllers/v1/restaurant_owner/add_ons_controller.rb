class V1::RestaurantOwner::AddOnsController < ApplicationController

  before_action :check_restaurant 
  before_action :check_add_on, only: [:show, :update]

  def create
    @add_on = RestaurantOwner::CreateAddOn.call(restaurant, add_on_params)
  end

  def show 
  end

  def update
    add_on.update(add_on_params)
    @add_on.reload
    render template: "v1/restaurant_owner/add_ons/show"
  end

  def destroy
  end

  protected

  def check_restaurant
    render json: { status: "400", message: "Request Missing RestaurantId"}, status: :bad_request  unless restaurant.present?
  end

  def add_on_params
    params.require(:add_ons).permit(:name, :min_quantity, :max_quantity,:items=>[ :name, :price ])
  end

  def item_params
    params.require(:add_on).permit(:items => [])
  end

  def restaurant
    @restaurant ||= Restaurant.find_by(id: restaurant_id)
  end

  def restaurant_id
    request.headers["restaurant-id"]
  end

  def add_on
    @add_on ||= restaurant.add_ons.find_by(id: params[:id])
  end

  def check_add_on
    unless add_on.present?
      render json: { status: {code: "400", message:"Invalid addOn params"} }, status: :bad_request
    end
  end
end
