class V1::SuperAdmin::UsersController < ApplicationController
  include Pagy::Backend

  def index
    users=AdminUser.all
    @pagy, @users= pagy(users, items: params[:per_page]&.to_i)
  end

  def show
    @user=AdminUser.find_by(id: params[:id])
  end

  def update
    user = AdminUser.find_by(id: params[:id])
    if user
      if user.update(is_blocked: params[:is_blocked])
        render json: { status: { code: "200", message: "User updated successfully", user: user } }, status: :ok
      else
        render json: { status: { code: "400", errors: user.errors.full_messages } }, status: :bad_request
      end
    else
      render json: { status: { code: "404", message: "No user found with the provided ID" } }, status: :not_found
    end
  end 
end
