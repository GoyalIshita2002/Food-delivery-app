class V1::Customer::MiscellaneousController < ApplicationController
  skip_before_action :authenticate_user!

  def check_email_availability
    if Customer.find_by(email: params[:email]).present?
      render json: { status: { code: "400", message: "There was already an account exist with this email"}}, status: :bad_request
    elsif 
      render json: { status: { code: "200", message: "Email is available to use"}}, status: :ok
    end
  end

  def check_email_param
    render json: { status: { code: "400", message: "Missing email" }}, status: :bad_request unless params[:email].present?
  end

end 
