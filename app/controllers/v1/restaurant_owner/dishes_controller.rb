class V1::RestaurantOwner::DishesController < ApplicationController
  before_action :check_restaurant
  before_action :check_dish, only: [:show, :update, :upload_image, :destroy]

  def create
    created_dish = RestaurantOwner::CreateDish.call(restaurant, dish_params)
    if created_dish.persisted?
      render json: { status: { code: "200", message: "Dish Added successfully"}, data: created_dish.as_json.merge(dish_type: created_dish.dish_type) }, status: :ok 
    else
      render json: { status: { code: "400", message: "Failed to add dish", errors: created_dish&.errors&.full_messages }},status: :bad_request and return
    end
  end

  def show
    render json: { status: { code: "200"}, data: dish.as_json.merge(image_url: dish.reload.image_url, dish_type: dish.dish_type) }, status: :ok and return
  end

  def update
    updated_dish = RestaurantOwner::UpdateDish.call(dish, dish_params)
    if updated_dish.persisted?
      render json: { status: { code: "200", message: "Dish updated successfully"}, data: updated_dish.as_json.merge(dish_type: updated_dish.dish_type) }, status: :ok
    else
      render json: { status: { code: "400", message: "Failed to update dish", errors: updated_dish&.errors&.full_messages }},status: :bad_request and return
    end
  end

  def index
    render json: { status: { code: "200"}, data: restaurant.dishes }, status: :ok 
  end

  def types 
    render json: { status: { code: "200"}, data: DishType.all }, status: :ok
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
    data = Hash.new
    DishType.includes(:dishes).each do |type|
        data[type.title] = type.dishes
    end
    render json: { status: { code: "200"}, data: data }, status: :ok                  
  end

  def popular
    render json: { status: { code: "200"}, data: restaurant.dishes.where(is_popular: true) }, status: :ok 
  end

  protected

  def validate_image
    unless params[:image].present?
      render json: { status: { code: "400", message: "Request missing image params" }}, status: :bad_request
    end
  end

  def dish_params
    params.require(:dish).permit(:name, :dish_type, :price, :description, :is_popular)
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
