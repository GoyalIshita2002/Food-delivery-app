class V1::Customer::ProfileController < ApplicationController
  skip_before_action :authenticate_user! , only: [:forget_password,:reset_password,:resend_otp,:verify_otp]
  def verify_otp
   # unless (CustomerOtp.find_by(otp: params[:otp])&.customer_id == current_customer.id)
     #   render json: { status: { code: "400", message: "Invalid OTP" }}, status: :bad_request and return
     # end
     customer_otp = CustomerOtp.find_by(otp: params[:otp])&.customer
      if customer_otp
        customer.update(is_verified: true)
        @customer=customer
      else
        render json: { status: { success: false, code: "400", message: "Invalid OTP" }}, status: :bad_request and return
       end    
  end 

  def update_phone
    unless current_customer.update!(phone_params.merge(is_verified: false))
      render json: { status: { code: "400", message: "Invalid params" }}, status: :bad_request and return
    end
    render template: "v1/customer/profile/update"
  end
 
  def delete_avatar
    current_customer.avatar.purge
    current_customer.save
    current_customer.reload
    render template: "v1/customer/profile/update"
  end

  def update
    unless current_customer.update(profile_params)
      render json: { status: { code: "400", message: "Invalid params"}, errors: current_customer.errors.full_messages }, status: :bad_request and return
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

  def resend_otp
    if customer.present?
      customer.customer_otp.destroy if customer.customer_otp.present?
      otp = customer.verification_otp
      render json: { status: { success: true, code: "200", message: "OTP resent successfully", new_otp: otp}}
    else
      render json: { status: { code: "400", message:"customer is not present" }}, status: :bad_request and return
    end  
  end

  def forget_password
    customer = Customer.find_by(email: params[:email])

    if customer.present?
       customer.generate_reset_password_token
      render json: {status: {message:"the link for reset password is send in your email. please check it...", }, reset_token: customer.reset_password_token}
    else
      render json: {status: {message:" Email ID not found"}}, status: :not_found 
    end
  end 

  def reset_password
    customer = Customer.find_by(reset_password_token: params[:reset_password_token])
    if customer.present?
      if customer.update(password: params[:password])
        render json: {status: "200", message: "Password Reset Successfully"}
      else
        render json: {error: customer.errors.full_messages}, status: :unprocessable_entity
      end
    else 
      render json: {status: "404", message: "Token is not valid "}, status: :not_found 
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
    params.permit(:username, :email, :dob,:doa, :std_code, :avatar)
  end

  def phone_params
    params.permit(:phone)
  end

  def customer
    Customer.find_by(email: params[:email])
  end
end 
