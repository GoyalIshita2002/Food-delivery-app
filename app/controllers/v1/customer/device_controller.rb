class V1::Customer::DeviceController < ApplicationController

  def create
    device = current_customer.devices.build(device_params)
    if device.save
      render json: device, status: :ok
    else
      render json: { status: { code: "400", errors: device.errors.full_messages }}, status: :bad_request
    end
  end
  
  private
  
  def device_params
    params.require(:device).permit(:device_type, :device_token)
  end
      
end
