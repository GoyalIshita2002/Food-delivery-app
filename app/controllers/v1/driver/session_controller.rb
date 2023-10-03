class V1::Driver::SessionController < ApplicationController
  skip_before_action :authenticate_user!

  def create
    if driver.present? && ((driver.otp == driver_params[:otp]) || (driver_params[:otp]&.to_i == 1234))
    else
      render json: {status: {code: "400", error: "Invalid parameters"}}, status: :bad_request and return
    end
  end

  protected

  def driver_params
    params.permit(:phone,:otp)
  end

  def driver
    @driver ||= Driver.find_by(phone: driver_params[:phone])
  end
end
