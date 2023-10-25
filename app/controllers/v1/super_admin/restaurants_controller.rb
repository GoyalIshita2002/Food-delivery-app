class V1::SuperAdmin::RestaurantsController < ApplicationController
  include Pagy::Backend

  before_action :validate_restaurant, only: :update

  def create
    @admin = SuperAdmin::CreateRestaurant.call(restaurant_admin_params)
    unless @admin.persisted?
      render json: { status: { code: "400", message: "Failed to create Restaurant" }},status: :bad_request and return  
    end
  rescue => e
    render json: { status: { code: "400", message: e.message }}, status: :bad_request and return
  end

  def update
    ActiveRecord::Base.transaction do 
      SuperAdmin::UpdateUserProfile.call(restaurant_admin_update_params, restaurant_owner) if restaurant_admin_update_params.present?
      SuperAdmin::UpdateRestaurant.call(restaurant_update_params, restaurant) if restaurant_update_params.present?
    end
  rescue => e
    render json: { status: { code: "400", message: e.message }}, status: :bad_request and return
  end 

  def edit
    @restaurant = Restaurant.find_by(id: params[:id])
    unless @restaurant.present?
      render json: { status: { code: "404", message: "Invalid Restaurant ID"}},status: :not_found and return
    end
  end

  def index
    restaurants = if params[:search].present?
      search = params[:search].downcase
      Restaurant.joins(:admin_user).where('lower(admin_users.email) LIKE ?', "%#{search}%")
      .or(Restaurant.where('lower(name) LIKE ?', "%#{search}%"))
      .or(Restaurant.where('lower(admin_users.phone) LIKE ?', "%#{search}%"))  
    else
      Restaurant.all
    end
    
    @pagy, @restaurants = pagy(restaurants, items: params[:per_page]&.to_i)
  end

  protected

  def restaurant_admin_params
    params.require(:restaurant_admin).permit(:email,:user_name, :password, :phone, :avatar, :restaurant => {})
  end

  def restaurant_admin_update_params
    params.require(:restaurant_admin).permit(:email,:user_name, :phone, :avatar) if params[:restaurant_admin].present?
  end

  def restaurant_update_params
    params.require(:restaurant_admin).permit(:restaurant => {}) if params[:restaurant_admin][:restaurant].present?
  end

  def restaurant
    @restaurant ||= Restaurant.find_by(id: params[:id])
  end

  def restaurant_owner
    restaurant.admin_user
  end

  def validate_restaurant
    unless restaurant.present?
      render json: { status: { code: "400", message: "Invalid Restaurant Id"}}, status: :bad_request and return
    end
  end
end
 