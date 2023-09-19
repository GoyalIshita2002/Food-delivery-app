class V1::Customer::CartsController < ApplicationController
  before_action :validate_cart

  def show
  end
  
  protected

  def validate_cart
    create_cart unless cart.present?
  end

  def cart
    @cart ||= current_customer.cart
  end

  def create_cart
    current_customer.carts.create
    cart
  end
end
