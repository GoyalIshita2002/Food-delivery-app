# frozen_string_literal: true

module V1
  module RestaurantOwner
    class SessionsController < Devise::SessionsController
      respond_to :json 
      skip_before_action :authenticate_admin_user!, only: :create

      def create
        admin = RestaurantAdmin.find_by(email: sign_in_params[:email])
        if admin&.valid_for_authentication? { admin.valid_password?(sign_in_params[:password]) }
          render json: {
            status: 200,
            message: "signin successful",
            data: admin,
            restaurant: admin.restaurants.last,
            auth_token: admin.generate_jwt,
          },status: :ok
        else
          render json: {
            status: 401,
            message: "Invalid Credentials"
          },status: :unauthorized
        end
      end

      def sign_in_params
        params.require(:restaurant_owner).permit(:email,:password)
      end

      def respond_to_on_destroy
        debugger
        jwt_payload = JWT.decode(request.headers['Authorization'].split(" ")[1], Rails.application.credentials.fetch(:secret_key_base))&.first
        current_admin_user = RestaurantAdmin.find_by(jti: jwt_payload['jti'])
        if current_admin_user.present?
          render json: { status: 200, message: "Signed out successfully"},status: :ok and return
        else
          render json: { status:401, message: "No Active session to signout"},status: :unauthorized
        end
      end
    end
  end
end
