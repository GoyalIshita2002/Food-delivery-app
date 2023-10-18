# frozen_string_literal: true

module V1
  module RestaurantOwner
    class SessionsController < Devise::SessionsController
      respond_to :json 
      skip_before_action :authenticate_user!, only: :create

      def create
        @admin = AdminUser.find_by(email: sign_in_params[:email])
        if @admin&.valid_for_authentication? { @admin.valid_password?(sign_in_params[:password]) }
          render template: "v1/restaurant_owner/profile/update"
        else
          render json: {
            status: 401,
            message: I18n.t("session.signin.failure"),
          },status: :unauthorized
        end
      end

      def sign_in_params
        params.permit(:email,:password)
      end

      def respond_to_on_destroy
        jwt_payload = JWT.decode(request.headers['Authorization'].split(" ")[1], Rails.application.credentials.fetch(:secret_key_base))&.first
        current_admin_user = AdminUser.find_by(jti: jwt_payload['jti'])
        if current_admin_user.present?
          render json: { status: 200, message: I18n.t("session.signout.success") },status: :ok and return
        else
          render json: { status:401, message: I18n.t("session.signout.failure") },status: :unauthorized
        end
      end
    end
  end
end
