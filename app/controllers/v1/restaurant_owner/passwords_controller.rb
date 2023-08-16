class V1::RestaurantOwner::PasswordsController < ApplicationController

  before_action :validate_restaurant_admin

  def update
    if restaurant_admin.present? && restaurant_admin.update(password_update_params)
      render json:{ status:"200", message: "password updated successfully"}, status: :ok and return
    else
      render json:{ status: "400", message: @user.errors.map(&:full_message)}, status: :bad_request and return
    end
  end

  def password_update_params
    params.require(:restaurant_owner).permit(:password,:password_confirmation)
  end

  def password_params
    params.require(:restaurant_owner).permit(:email, :current_password, :password, :password_confirmation)
  end

  def restaurant_admin
    @restaurant_admin ||= RestaurantAdmin.find_by(email: password_params[:email])
  end

  def validate_restaurant_admin
    unless restaurant_admin.present?
      render json: { status: { code: "422", message: "invalid user ID"} }, status: :bad_request and return
    end
    unless restaurant_admin&.valid_for_authentication? { restaurant_admin.valid_password?(password_params[:current_password]) }
      render json: { status: { code: "422", message: "invalid current password"} }, status: :bad_request and return
    end
  end
end
