class V1::RestaurantOwner::DishesController < ApplicationController
  before_action :check_restaurant
  before_action :check_dish, only: [:show, :update, :upload_image, :destroy]

  def create
    @dish = RestaurantOwner::CreateDish.call(restaurant, dish_params)
    unless @dish.persisted?
      render json: { status: { code: "400", message: "Failed to add dish", errors: @dish&.errors&.full_messages }},status: :bad_request and return
    end
  end

  def update
    @dish = RestaurantOwner::UpdateDish.call(dish, dish_params)
    unless @dish.persisted?
      render json: { status: { code: "400", message: "Failed to update dish", errors: @dish&.errors&.full_messages }},status: :bad_request and return
    end
  end

  def index
    @dishes = restaurant.dishes
  end

  def types 
    @dish_types = DishType.all
  end

  def upload_image
    if dish.update!(image: params[:image])
      render json: { status: {code: "200", message:"Image updated successfully"}, image_url: dish.reload.image_url },status: :ok
    else
      render json: { status: { code:"400", message: "Image upload failed", errors: dish&.errors&.full_messages} }, status: :bad_request
    end
  end

  def destroy
    destroyed_dish = dish.destroy
    unless destroyed_dish.persisted?
      render json: { status: { code: "200", message: "Dish deleted successfully"}}, status: :ok
    else
      render json: { status: { code: "400", message: "Failed to destroy dish"}}, status: :bad_request
    end
  end

  def dishes_by_type
    @dish_types = DishType.includes(:dishes)               
  end

  def popular
    @dishes = restaurant.dishes.where(is_popular: true)
    render template: "v1/restaurant_owner/dishes/index"
  end

  def dishes_availability 
    restaurant.dishes.where(id: availability_params[:available]).update_all(is_available: true)  if availability_params[:available].present?
    restaurant.dishes.where(id: availability_params[:unavailable]).update_all(is_available: false) if availability_params[:unavailable].present?
    @dishes = restaurant.dishes.order(:id)
    render template: "v1/restaurant_owner/dishes/index"
  end

  def popular_dishes
    restaurant.dishes.where(id: popular_dishes_params[:popular]).update_all(is_popular: true)   if popular_dishes_params[:popular].present?
    restaurant.dishes.where(id: popular_dishes_params[:unpopular]).update_all(is_popular: false)  if popular_dishes_params[:unpopular].present?
    @dishes = restaurant.dishes.order(:id)
    render template: "v1/restaurant_owner/dishes/index"
  end

  protected

  def availability_params
    params.require(:dishes).permit(:available => [], :unavailable => [])
  end

  def popular_dishes_params
    params.require(:dishes).permit(:popular => [], :unpopular => [])
  end

  def validate_image
    unless params[:image].present?
      render json: { status: { code: "400", message: "Request missing image params" }}, status: :bad_request
    end
  end

  def dish_params
    params.require(:dish).permit(:name, :dish_type, :price, :description, :is_popular, :add_ons=>[:id, :name, :sub_item_ids=>[]])
  end

  def check_restaurant
    unless restaurant.present?
      render json: { status: "404", message: "invalid Restaurant/Dish"}, status: :not_found and return
    end
  end

  def restaurant
    @restaurant ||= Restaurant.find_by(id: restaurant_id)
  end

  def dish
    @dish ||= restaurant.dishes.find_by(id: params[:id])
  end

  def check_dish
    unless dish.present?
      render json: { status: "404", message: "Missing Restaurant/Dish ID"}, status: :not_found and return
    end
  end

  def restaurant_id
    params[:restaurant_id] || request.headers["restaurant-id"]
  end
end
