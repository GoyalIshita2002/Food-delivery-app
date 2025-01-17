class V1::Customer::SessionsController < Devise::SessionsController
  respond_to :json

  skip_before_action :authenticate_user!

  # POST /resource/sign_in
  def create
    customer = Customer.find_by(email: sign_in_params[:email])
    
    unless customer&.valid_for_authentication? { customer.valid_password?(sign_in_params[:password]) }
      render json: {
        status: 401,
        message: I18n.t('session.signin.failure')
      },status: :unauthorized
    end
    if customer.present? && customer.is_blocked
      render json: {
        status: 401,
        message: "Blocked user"
      },status: :unauthorized and return
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
      render json: { status: 200, message: I18n.t('session.signout.success')},status: :ok
    else
      render json: { status:401, message: I18n.t('session.signout.failure')},status: :unauthorized
    end
  end
end
