class V1::Driver::ProfileController < ApplicationController
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
    current_driver.driver_otp.destroy if current_driver.driver_otp.present?
    otp = current_driver.verification_otp
    render json: { status: { success: true, code: "200", message: "OTP resent successfully", new_otp: otp}}
  end

  protected

  def profile_params
    params.permit(:full_name, :email, :dob, :address,:avatar)
  end

end
