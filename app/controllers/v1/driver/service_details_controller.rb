class V1::Driver::ServiceDetailsController < ApplicationController
  def create
    current_driver.service_location.destroy
    service_detail=current_driver.build_service_location(service_location_params)
     if service_detail.save
       render json: { status: { code: "200", message: "service location created succesfully"}}, status: :ok and return
     else
       render json: { status: { code: "400", errors: service_detail.errors.full_messages }}, status: :bad_request and return
     end
   end
 
   private
   def service_location_params
     params.permit(:vehicle, :address, :street, :country, :state, :latitude, :longitude)
   end
end
