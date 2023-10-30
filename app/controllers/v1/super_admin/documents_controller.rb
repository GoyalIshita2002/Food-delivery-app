class V1::SuperAdmin::DocumentsController < ApplicationController
  before_action :set_restaurant, only: :create
  
  def create
    if params[:documents].present?
      if restaurant.present?
        @restaurant_files = []
        params[:documents].each do |file|
<<<<<<< HEAD
          restaurant_file = restaurant.restaurant_files.create(name: params[:name])
          restaurant_file.file.attach(file)
          @restaurant_files << rails_blob_url(restaurant_file.file)
=======
          @restaurant_file = restaurant.restaurant_files.create(name: params[:name])
          @restaurant_file.file.attach(file)
>>>>>>> 559ad6a8c39707433ffa18f2412cad4037c33854
        end
        render json: { success: true, message: 'Files uploaded successfully', document_urls: @restaurant_files }
      else
        render json: { error: 'Restaurant not found with the provided ID' }, status: :unprocessable_entity
      end
    else
      render json: { error: 'No files uploaded' }, status: :unprocessable_entity
    end
  end

  def index
    if restaurant.present?
      @restaurant_files = restaurant.restaurant_files
      if @restaurant_files.present?
        render template: "v1/super_admin/documents/index",status: :ok and return
      else
         render json: { documents: [] }, status: :ok
      end
    else
      render json: { error: 'Restaurant not found with the provided ID' }, status: :unprocessable_entity
    end
  end

  def destroy
    document = restaurant.restaurant_files.find_by(id: params[:id])
    unless document.present?
      render json: { status: { code: "400", message: "Invalid Document ID" } }, status: :bad_request and return
    end
    document_url = rails_blob_url(document.file)
    if document.destroy
      render json: { status: { code: "200", message: "Document destroyed successfully", document_url: document_url } }, status: :ok and return
    else
      render json: { status: { code: "400", message: "Failed to destroy document" } }, status: :bad_request and return
    end
  end

  private 

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
