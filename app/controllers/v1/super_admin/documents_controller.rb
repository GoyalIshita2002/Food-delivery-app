class V1::SuperAdmin::DocumentsController < ApplicationController
  before_action :set_restaurant, only: :create
  
  def create
    if params[:documents].present?
      if restaurant.present?
        @restaurant_files = []
        params[:documents].each do |file|
          restaurant_file = restaurant.restaurant_files.create(name: params[:name])
          restaurant_file.file.attach(file)
          @restaurant_files << rails_blob_url(restaurant_file.file)
        end
        render json: { success: true, message: 'Files uploaded successfully', document_urls: @restaurant_files }
      else
        render json: { error: 'Restaurant not found with the provided ID' }, status: :unprocessable_entity
      end
    else
      render json: { documents: [] }, status: :ok
    end
  end

  def index
    if restaurant.present?
      @restaurant_files = restaurant.restaurant_files
      unless @restaurant_files.present?
        render json: { documents: [] }, status: :ok
      end 
    else
      render json: { error: 'Restaurant not found with the provided ID' }, status: :unprocessable_entity
    end
  end
  
  def destroy
    document = restaurant.restaurant_files.find_by(id: params[:id])
    unless document
      render json: { status: { code: "400", message: "Invalid Document ID" } }, status: :bad_request and return
    end
    if document.destroy
      render json: { status: { code: "200", message: "Document destroyed successfully" } }, status: :ok
    else
      render json: { status: { code: "400", message: "Failed to destroy document" } }, status: :bad_request
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
