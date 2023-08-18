class V1::RestaurantOwner::DishesController < ApplicationController

  before_action :check_restaurant
  before_action :check_dish, only: [:show, :update, :upload_image]

  def create
    created_dish = restaurant.dishes.create(dish_params)
    if created_dish.persisted?
      render json: { status: { code: "200", message: "Dish Added successfully"}, data: created_dish }, status: :ok 
    else
      render json: { status: { code: "422", message: "Failed to add dish", errors: dish&.errors&.full_messages }},status: :bad_request and return
    end
  end

  def show
    render json: { status: { code: "200"}, data: dish.as_json.merge(image_url: dish.reload.image.url) }, status: :ok and return
  end

  def update
    if dish.update!(dish_params)
      render json: { status: { code: "200", message: "Dish updated successfully"}, data: dish.reload }, status: :ok
    else
      render json: { status: { code: "422", message: "Failed to update dish", errors: dish&.errors&.full_messages }},status: :bad_request and return
    end
  end

  def index
    render json: { status: { code: "200"}, data: restaurant.dishes }, status: :ok 
  end

  def types 
    render json: { status: { code: "200"}, data: Dish.dish_types }, status: :ok
  end

  def upload_image
    if dish.update!(image: params[:image])
      render json: { status: {code: "200", message:"Image updated successfully"}, image_url: dish.reload.image.url },status: :ok
    else
      render json: { status: { code:"422", message: "Image upload failed", errors: dish&.errors&.full_messages} }, status: :bad_request
    end
  end

  protected

  def validate_image
    unless params[:image].present?
      render json: { status: { code: "422", message: "Request missing image params" }}, status: :bad_request
    end
  end

  def dish_params
    params.require(:dish).permit(:name, :dish_type, :price, :description, :is_popular)
  end

  def check_restaurant
    unless restaurant.present?
      render json: { status: "404", message: "invalid Restaurant"}, status: :bad_request and return
    end
  end

  def restaurant
    @restaurant ||= Restaurant.find_by(id: params[:restaurant_id])
  end

  def dish
    @dish ||= restaurant.dishes.find_by(id: params[:id])
  end

  def check_dish
    unless dish.present?
      render json: { status: "404", message: "invalid Restaurant"}, status: :bad_request and return
    end
  end
end
