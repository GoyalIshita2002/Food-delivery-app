class Customer::OrderCreationService < ApplicationService
    def initialize(customer, order_params, note_content)
      @customer = customer
      @order_params = order_params
      @note_content = note_content
    end
     
    def call
     create_order
    end

    def create_order
      order = @customer.orders.build(@order_params)
      if order.save
        create_order_note(order) if @note_content.present?
        @customer.cart.update(status: :ordered) if (@customer.present? && @customer.cart.present?)
        { status: { code: "200", message: "order created successfully" } }
      else
        { status: { code: "400", errors: order.errors.full_messages } }
      end
    end
  
    private
  
    def create_order_note(order)
      order.build_order_note(content: @note_content).save
    end
  end