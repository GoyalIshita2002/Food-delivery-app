class V1::RestaurantOwner::AddOnsController < ApplicationController

  before_action :check_restaurant 
  before_action :check_add_on, only: [:show, :update, :destroy, :items_destroy]

  def create
    @add_on = RestaurantOwner::CreateAddOn.call(restaurant, add_on_params)
  end

  def show
  end
  
  def update
    @add_on = RestaurantOwner::UpdateAddOn.call(add_on, add_on_params)
    @add_on.reload
    render template: "v1/restaurant_owner/add_ons/show"
  end

  def index
    @add_ons = add_on_items
  end
  
  def destroy
    if add_on.update!(is_deleted: true)
       add_on.items.update!(is_deleted: true)
       @add_ons = restaurant.add_ons
      render template: "v1/restaurant_owner/add_ons/index"
    else
      render json: { status: { code: "400", message: "Failed to destroy add-on"}, errors: add_on.errors.map(&:full_messages)  }, status: :bad_request
    end
  end

  def items_destroy
   item = add_on.items.find_by(id: params[:item_id])
    if item.present?
     item.update(is_deleted: true)
     render template: "v1/restaurant_owner/add_ons/show"
    else
      render json: { status: { code: "400", message: "Failed to destroy items of add-on"}, errors: add_on.errors.map(&:full_messages)  }, status: :bad_request
   end
  end

  protected
   
  def add_on_items 
    restaurant.add_ons.includes(:items).where(items: { is_deleted: false })
    end
  
  def check_restaurant
    render json: { status: "400", message: "Request Missing RestaurantId"}, status: :bad_request  unless restaurant.present?
  end

  def add_on_params
    params.require(:add_ons).permit(:name ,:items=>[ :id, :name, :price, :min_quantity, :max_quantity,:is_deleted ])
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
    @add_on ||= restaurant.add_ons.find_by(id: params[:id], is_deleted: false)
  end

  def check_add_on
    unless add_on.present?
      render json: { status: {code: "400", message:"Invalid addOn params"} }, status: :bad_request
    end
  end
end
