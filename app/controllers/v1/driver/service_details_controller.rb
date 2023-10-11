class V1::Driver::ServiceDetailsController < ApplicationController
  def create
    service_detail=current_driver.build_service_detail(service_detail_params)
     if service_detail.save
       render json: { status: { code: "200", message: "service_details created succesfully"}}, status: :ok and return
     else
       render json: { status: { code: "400", errors: service_detail.errors.full_messages }}, status: :bad_request and return
     end
   end
 
   private
   def service_detail_params
     params.permit(:vehicle,:locality)
   end
end
