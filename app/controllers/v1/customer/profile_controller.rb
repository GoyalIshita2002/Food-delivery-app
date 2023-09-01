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

  def profile_params
    params.permit(:username, :email, :dob,:doa, :std_code, :phone, :avatar)
  end
end 
