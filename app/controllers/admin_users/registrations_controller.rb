# frozen_string_literal: true

class AdminUsers::RegistrationsController < Devise::RegistrationsController
  respond_to :json
  skip_before_action :authenticate_user!, only: :create
  before_action :configure_sign_up_params, only: [:create]

  def create
    ActiveRecord::Base.transaction do
      super
      CreateRestaurant.call(restaurant_params, resource) if resource.persisted? && restaurant_params.present?
    end
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:user_name, :role , :email, :password, :avatar, :phone) }
  end

  def respond_with(resource, options={})
    if resource.persisted?
      render json: { status: "200", message:"signed up successfully", data: resource }
    else 
      render json: { status: "422", message: "Registration failed", errors: resource.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def restaurant_params
    params.require(:admin_user).permit(:restaurant=>[:name, :type, :open_time, :close_time, :restaurant_address=>[:street, :address, :zip_code, :state]])
  end
end
