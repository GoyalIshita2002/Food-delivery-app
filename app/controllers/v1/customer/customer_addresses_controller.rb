class V1::Customer::CustomerAddressesController < ApplicationController

  before_action :validate_address, only: :update

  def create
    address = current_customer.addresses.create!(address_params)
    if address.errors.full_messages.present?
      render json: { sttaus: {code: "400", errors: address.errors.full_messages}}, status: :bad_request and return
    end
  end

  def update
    unless address.update!(address_params)
      render json: {status: {code: "400", errors: address.errors.full_messages }},status: :bad_request and return 
    end
  end

  def index
    if params[:search].present?
      search = params[:search].downcase
      customer_address = current_customer.addresses.where('lower(street) LIKE ?', "%#{search}%")
                                        .or(CustomerAddress.where('lower(address) LIKE ?', "%#{search}%"))
                                        .or(CustomerAddress.where('lower(zip_code) LIKE ?', "%#{search}%"))
                                        .or(CustomerAddress.where('lower(state) LIKE ?', "%#{search}%"))
    else
      customer_address = current_customer.addresses
    end
    render json: { customer_address: customer_address }, status: :ok
  end


  protected

  def validate_address
    unless address.present?
      render json: { status: {code: "400", message: "invalid Address ID"}}, status: :bad_request and return
    end
  end

  def address
    @address ||= current_customer.addresses.find_by(id: params[:id])
  end

  def address_params
    params.require(:address).permit(:street, :address, :zip_code, :state, :address_type, :is_default)
  end
end

