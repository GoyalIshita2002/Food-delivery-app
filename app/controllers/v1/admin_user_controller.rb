class V1::AdminUserController < ApplicationController
  skip_before_action :authenticate_admin_user!, only: :check_account_availability

  def check_account_availability
    unless params[:email].present?
      render json: {status: "400", message: "Email missing" }, status: :bad_request and return
    end
    current_admin_user = AdminUser.find_by(email: params[:email])
    if current_admin_user.present? && current_admin_user.franchise_owner?
      render json: {status: "422", message: "Owner Account already exists"}, status: :unprocessable_entity and return 
    elsif current_admin_user.present? && !current_admin_user.franchise_owner?
      render json: {status: "422", message: "Account already exists with different role"}, status: :unprocessable_entity and return 
    else
      render json: {status: "200", message: "Email available to register"}, status: :ok and return
    end
  end 
end
