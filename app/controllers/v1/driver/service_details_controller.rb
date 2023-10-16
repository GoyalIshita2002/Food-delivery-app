class V1::Driver::ServiceDetailsController < ApplicationController
  def create
    current_driver.service_location.destroy if current_driver.service_location.present?
    service_detail = current_driver.build_service_location(service_location_params)
    @driver=current_driver
      unless service_detail.save
        render json: { status: { code: "400", errors: service_detail.errors.full_messages }}, status: :bad_request and return
      end
   end
 
   private
   def service_location_params
     params.permit(:vehicle, :address, :street, :country, :state, :latitude, :longitude)
   end
end
