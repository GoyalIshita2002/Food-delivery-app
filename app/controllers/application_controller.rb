class ApplicationController < ActionController::API
  include Pundit::Authorization
  respond_to :json
  before_action :authenticate_user!

  def authenticate_user!
    unless request.headers['Authorization'].present?
      render json: { status: {code:"401", message: "unauthorized request" }}, status: :unauthorized and return
    end
    jwt_payload = JWT.decode(request.headers['Authorization'].split(" ")[1], Rails.application.credentials.fetch(:secret_key_base))&.first

    if request.url.include?('v1/super_admin')
      @current_super_admin = SuperAdmin.find_by(id: jwt_payload['sub'])
      unless @current_super_admin.present?
        render json: { status: { code: "401", message: "Invalid JWT token"}},status: :unauthorized and return
      end
    elsif request.url.include?('v1/restaurant_owner')
      @current_admin_user = AdminUser.find_by(id: jwt_payload['sub'])
      unless @current_admin_user.present?
        render json: { status: { code: "401", message: "Invalid JWT token"}},status: :unauthorized and return
      end  
    else
    end
  end
end
