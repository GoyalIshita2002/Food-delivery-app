class V1::SuperAdmin::DocumentsController < ApplicationController
  before_action :set_restaurant, only: :create

  # def create
  #   @document = restaurant.documents.create(document_params)
  #   unless @document.persisted?
  #     render json: { status: "400", error: "Upload Failed"},status: :bad_request and return
  #   end
  # rescue => e
  #   render json: { status: "400", error: e.message },status: :bad_request and return
  # end 
  
  def create 
    if params[:documents].present?
      if restaurant.present?
        params[:documents].each do |file|
          restaurant_file = restaurant.restaurant_files.create(name: params[:name])
          restaurant_file.file.attach(file)
        end
        render json: { success: true, message: 'Files uploaded successfully' }
      else
        render json: { error: 'Restaurant not found with the provided ID' }, status: :unprocessable_entity
      end
    else
      render json: { error: 'No files uploaded' }, status: :unprocessable_entity
    end
  end


  def index
    @documents = restaurant.documents
  end

  def destroy
    document = Document.find_by(id: params[:id])
    unless document.present?
      render json: {status: {code: "400", message: "Invalid Document ID"}}, sttaus: :bad_request and return
    end
    if document.destroy!
      render json: { status: {code: "200", message: "Document destroyed successfully"}}, status: :ok and return
    else
      render json: {status: {code: "400", message: "Invalid Document"}}, status: :bad_request and return
    end
  end

  private 

  def document_params
    params.permit(:name,:front,:back)
  end

  def restaurant_id
    params[:restaurant_id] 
  end

  def restaurant
    @restaurant ||= Restaurant.find_by(id: restaurant_id)
  end

  def set_restaurant
    unless restaurant.present?
      render json: {status: "400", error: "Restaurant Id required"}, status: :bad_request and return
    end
  end
end
