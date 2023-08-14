class ApplicationController < ActionController::API
  include Pundit::Authorization
  respond_to :json
  before_action :authenticate_admin_user!
end
