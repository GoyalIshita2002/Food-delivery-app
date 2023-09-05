class V1::Customer::ProfileController < ApplicationController

  def verify_otp
    unless (CustomerOtp.find_by(otp: params[:otp])&.customer_id == current_customer.id)
      render json: { status: { code: "400", message: "Invalid OTP" }}, status: :bad_request and return
    end 
    current_customer.update(is_verified: true)
  end
 
  def delete_avatar
    current_customer.avatar.purge
    current_customer.save
    current_customer.reload
    render template: "v1/customer/profile/update"
  end

  def update
    unless current_customer.update!(profile_params)
      render json: { status: { code: "400", message: "Invalid params" }}, status: :bad_request and return
    end
  end

  def update_password
    unless current_customer.present? && current_customer.valid_password?(current_password)
      render json: { status: { code: "400", message: "invalid current credentials" }}, status: :bad_request and return
    end

    unless current_customer.update(password_update_params)
      render json: { status: { code: "400", message: "Password update failed"}}, status: :bad_request and return
    else
      render json:{ status:"200", message: "password updated successfully"}, status: :ok and return
    end
  end

  protected

  def password_params
    params.permit(:current_password, :password, :password_confirmation)
  end

  def current_password
    password_params[:current_password]
  end

  def password_update_params
    password_params.permit(:password, :password_confirmation)
  end

  def profile_params
    params.permit(:username, :email, :dob,:doa, :std_code, :phone, :avatar)
  end
end 
