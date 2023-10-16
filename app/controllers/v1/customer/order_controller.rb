class V1::Customer::OrderController < ApplicationController
    
    def create
      service = Customer::OrderCreationService.new(current_customer, order_params, params[:content])
      result = service.create_order
      render json: result, status: (result[:status][:code] == "200" ? :ok : :bad_request)
    end

    def update
        order = current_customer.orders.find(params[:order_id])
       if order.update(status: 1)
        render json: { status: { code: "200", message: "order cancelled succesfully"}}, status: :ok and return
      else
        render json: { status: { code: "400", errors: order.errors.full_messages }}, status: :bad_request and return
      end 
    end

    private 

   def order_params
    params.require(:order).permit(:cart_id, :restaurant_id, :customer_address_id, :status,:driver_id).merge(customer_id: current_customer.id)
   end
  
   

end
