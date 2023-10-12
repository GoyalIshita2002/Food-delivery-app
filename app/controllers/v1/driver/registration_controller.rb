class V1::Driver::RegistrationController < ApplicationController
  skip_before_action :authenticate_user!

  def create
   @driver = driver || Driver.create(driver_params)
   unless @driver.persisted?
     render json: { status: { code: "400", error: @driver.errors.full_message}}, status: :bad_request and return
   end
  end

  protected

  def driver_params
    params.permit(:phone,:std_code)
  end

  def driver
    Driver.find_by(phone: driver_params[:phone])
  end
end
