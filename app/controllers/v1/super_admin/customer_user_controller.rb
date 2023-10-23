class V1::SuperAdmin::CustomerUserController < ApplicationController
  include Pagy::Backend

  def index
    users = if params[:search].present?
      search = params[:search].downcase
      Customer.where('lower(email) LIKE ?', "%#{search}%")
      .or(Customer.where('lower(username) LIKE ?', "%#{search}%"))
      .or(Customer.where('lower(phone) LIKE ?', "%#{search}%"))  
    else
      Customer.all
    end
    @pagy, @customer_users= pagy(users, items: params[:per_page]&.to_i)
  end

  def show
    @customer_user=Customer.find_by(id: params[:id])
  end
end
