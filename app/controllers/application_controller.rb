class ApplicationController < ActionController::API
  include Pundit::Authorization

  before_action :authenticate_admin_user!
end
