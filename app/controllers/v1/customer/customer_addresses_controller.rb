class V1::Customer::CustomerAddressesController < ApplicationController
  def create
    address = current_customer.addresses.create!(address_params)
    if address.errors.full_messages.present?
      render json: { sttaus: {code: "400", errors: address.errors.full_messages}}, status: :bad_request and return
    end
  end

  protected

  def address_params
    params.require(:address).permit(:street, :address, :zip_code, :state)
  end
end

