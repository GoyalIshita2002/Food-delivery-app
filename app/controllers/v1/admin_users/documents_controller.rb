class V1::AdminUsers::DocumentsController < ApplicationController
  before_action :set_restaurant, only: :create

  def create
    @document = @restaurant.documents.create(document_params)
    unless @document.persisted?
      render json: { status: "400", error: "Upload Failed"},status: :bad_request and return
    end
  rescue => e
    render json: { status: "400", error: e.message },status: :bad_request and return
  end 

  private 

  def document_params
    params.permit(:name,:front,:back)
  end

  def set_restaurant
    @restaurant ||= current_admin_user.restaurants.find_by(id: params[:restaurant_id])
    unless @restaurant.present?
      render json: {status: "400", error: "Restaurant Id required"}, status: :bad_request and return
    end
  end
end
