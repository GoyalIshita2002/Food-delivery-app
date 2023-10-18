class V1::SuperAdmin::UsersController < ApplicationController
  include Pagy::Backend

  def index
    users=AdminUser.all
    @pagy, @users= pagy(users, items: params[:per_page]&.to_i)
  end

  def show
    @user=AdminUser.find_by(id: params[:id])
  end
  
end
