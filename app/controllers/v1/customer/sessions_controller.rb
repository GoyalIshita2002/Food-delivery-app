class V1::Customer::SessionsController < Devise::SessionsController
  respond_to :json

  skip_before_action :authenticate_user!

  # POST /resource/sign_in
  def create
    customer = Customer.find_by(email: sign_in_params[:email])
    
    unless customer&.valid_for_authentication? { customer.valid_password?(sign_in_params[:password]) }
      render json: {
        status: 401,
        message: "Invalid Credentials"
      },status: :unauthorized
    end
    @current_customer = customer
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def sign_in_params
    params.permit(:email,:password)
  end

  def respond_to_on_destroy
    jwt_payload = JWT.decode(request.headers['Authorization'].split(" ")[1], Rails.application.credentials.fetch(:secret_key_base))&.first
    
    current_admin_user = AdminUser.find_by(id: jwt_payload['sub'])
    if current_admin_user.present?
      render json: { status: 200, message: "Signed out successfully"},status: :ok
    else
      render json: { status:401, message: "No Active session to signout"},status: :unauthorized
    end
  end
end
