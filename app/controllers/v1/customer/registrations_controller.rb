class V1::Customer::RegistrationsController < Devise::RegistrationsController
  respond_to :json
  skip_before_action :authenticate_user!, only: :create
  before_action :configure_sign_up_params, only: [:create]

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, :phone, :std_code, :password, :password_confirmation])
  end

  def respond_with(resource, options={})
    if resource.persisted?
      # render json: { status: "200", message:"signed up successfully", data: resource }
    else 
      render json: { status: "422", message: "Registration failed", errors: resource.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
