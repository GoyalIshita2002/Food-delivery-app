class AdminUsers::PasswordsController < Devise::PasswordsController
  respond_to :json

  before_action :validate_password

  def update
    if @user.present? && @user.update(password_update_params)
      render json:{ status:"200", message: "password updated successfully"}, status: :ok and return
    else
      render json:{ status: "400", message: @user.errors.map(&:full_message)}, status: :bad_request and return
    end
  end

  protected

  def password_update_params
    params.require(:admin_user).permit(:password,:password_confirmation)
  end

  def password_params
    params.require(:admin_user).permit(:email, :current_password, :password, :password_confirmation)
  end

  def validate_password
    @user ||= AdminUser.find_by(email: password_params[:email])
    current_password = password_params[:current_password]
    unless @user.present? && current_password.present? && @user.valid_password?(current_password)
      render json: { status: "400", message: "Invalid Email/Current password" }, status: :bad_request and return
    end
  end
end
