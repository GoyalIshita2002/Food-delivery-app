class V1::SuperAdmin::OrderController < ApplicationController

    def assign_driver 
      @order = Order.find_by(id: params[:order_id])
      if @order.present? 
        if params[:driver_id].present?
          @order.order_agent.destroy! if @order.order_agent.present?
          @order.create_order_agent(driver_id: params[:driver_id]) 
        end
        render json: @order,status: :ok and return
      else
        render json: { status: { code: "400", errors: @order.errors.full_messages }}, status: :bad_request 
      end   
    end
end
