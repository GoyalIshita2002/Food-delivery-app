class V1::Driver::DocumentsController < ApplicationController
  before_action :check_driver
   
  def create
    @document = current_driver.documents.create(document_params)
    unless @document.persisted?
      render json: { status: "400", error: "Upload Failed"},status: :bad_request and return
    end
  rescue => e
    render json: { status: "400", error: e.message },status: :bad_request and return
  end

  def index
    @documents = current_driver.documents
    unless @documents.present?
      render json: {status: {code: "404", message: "Document not found"}}
    end
  end

  def destroy
    document = current_driver.documents.find_by(id: params[:id])
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

  def check_driver
    unless current_driver.present?
      render json: {status: "400", error: "Driver Id required"}, status: :bad_request and return
    end
  end
end
