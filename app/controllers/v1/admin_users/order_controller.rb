class V1::AdminUsers::OrderController < ApplicationController

    def accept_order 
        @order = current_restaurant.orders.find(params[:order_id])
        if @order.present?
            @order.update(driver_id: params[:driver_id])
          render json: @order,status: :ok and return
        else
          render json: { status: { code: "400", errors: @order.errors.full_messages }}, status: :bad_request 
        end   
      end

      private

      def current_restaurant
        current_admin_user.restaurant
      end
end
