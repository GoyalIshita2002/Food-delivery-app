class V1::Driver::ProfileController < ApplicationController
  skip_before_action :authenticate_user! , only: [:resend_otp]

  def update
    @driver=current_driver
    unless current_driver.update(profile_params)
      render json: { status: { code: "400", errors: current_driver.errors.full_messages }}, status: :bad_request and return
    end
  end

  def delete_avatar
    current_driver.avatar.purge
    render json: {status: {code:"200",message:"profile image deleted successfully"}}
  end

  def show
    @driver=current_driver
  end

  def resend_otp
    debugger
    if driver.present?
     driver.driver_otp.destroy if driver.driver_otp.present?
     otp = driver.verification_otp
     render json: { status: { success: true, code: "200", message: "OTP resent successfully", new_otp: otp}}
    else
      render json: { status: { code: "400", message:"driver is not present" }}, status: :bad_request and return
    end 
  end

  protected

  def profile_params
    params.permit(:full_name, :email, :dob, :address,:avatar)
  end

  def driver
    Driver.find_by(phone: params[:phone])
  end


end
