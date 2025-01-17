class V1::SuperAdmin::RestaurantsController < ApplicationController
  include Pagy::Backend

  before_action :validate_restaurant, only: [:update, :suspend]

  def blob_creation
    blob = create_blob_from_image(params[:avatar])
    render json: { status: { code: "200", message: "Blob created successfully", blob_id: blob.id }}, status: :ok
  rescue => e
    render json: { status: { code: "400", message: e.message }}, status: :bad_request
  end

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
    @restaurant = Restaurant.unscope(where: :suspended).find_by(id: params[:id])
    unless @restaurant.present?
      render json: { status: { code: "404", message: "Invalid Restaurant ID"}},status: :not_found and return
    end
  end

  def index
    restaurants = if params[:search].present?
      search = params[:search].downcase
      Restaurant.unscope(where: :suspended).joins(:admin_user)
        .where('lower(admin_users.email) LIKE ?', "%#{search}%")
        .or(Restaurant.unscope(where: :suspended).where('lower(name) LIKE ?', "%#{search}%"))
        .or(Restaurant.unscope(where: :suspended).where('lower(restaurants.phone) LIKE ?', "%#{search}%"))
    else
      Restaurant.unscope(where: :suspended).all
    end
    @pagy, @restaurants = pagy(restaurants, items: params[:per_page]&.to_i)
  end
  
  def suspend
    if restaurant.update(suspended: true)
      render json:{status: { code: "200", message: "suspended successfully"}}, status: :ok
    else
      render json: {status: { code: "400", errors: restaurant.errors.full_messgaes }}, status: :bad_request
    end
  end

  protected

  def restaurant_admin_params
    params.require(:restaurant_admin).permit(:email,:user_name, :password, :phone, :restaurant => {})
  end

  def restaurant_admin_update_params
    params.require(:restaurant_admin).permit(:email,:user_name, :phone) if params[:restaurant_admin].present?
  end

  def restaurant_update_params
    params.require(:restaurant_admin).permit(:restaurant => {}) if params[:restaurant_admin][:restaurant].present?
  end

  def restaurant
    @restaurant ||= Restaurant.unscope(where: :suspended).find_by(id: params[:id])
  end

  def restaurant_owner
    restaurant.admin_user
  end

  def validate_restaurant
    unless restaurant.present?
      render json: { status: { code: "400", message: "Invalid Restaurant Id"}}, status: :bad_request and return
    end
  end

  def create_blob_from_image(image)
    ActiveStorage::Blob.create_and_upload!(
      io: image.open,
      filename: image.original_filename,
      content_type: image.content_type
    )
  end
end
 