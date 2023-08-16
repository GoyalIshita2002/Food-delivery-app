class ApplicationController < ActionController::API
  include Pundit::Authorization
  respond_to :json
  before_action :authenticate_admin_user!

  def authenticate_admin_user!
    unless request.headers['Authorization'].present?
      render json: { status: {code:"401", message: "unauthorized request" }}, status: :unauthorized and return
    end
  end
end
