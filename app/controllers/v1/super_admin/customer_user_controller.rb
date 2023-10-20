class V1::SuperAdmin::CustomerUserController < ApplicationController
  include Pagy::Backend

  def index
    users=Customer.all
    @pagy, @customer_users= pagy(users, items: params[:per_page]&.to_i)
  end

  def show
    @customer_user=Customer.find_by(id: params[:id])
  end
end
