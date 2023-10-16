class V1::SuperAdmin::OrderController < ApplicationController

    def accept_order 
        @order = Order.find_by(id: params[:order_id])
        if @order.present?
            @order.update(driver_id: params[:driver_id])
          render json: @order,status: :ok and return
        else
          render json: { status: { code: "400", errors: @order.errors.full_messages }}, status: :bad_request 
        end   
      end

      

     
end
