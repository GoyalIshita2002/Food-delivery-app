class V1::Customer::CartItemsController < ApplicationController

  before_action :validate_cart, only: :create
  before_action :validate_item_params, only: :create

  def create
    SuperAdmin::AddCartItem.call(cart_item_params, cart)
  end

  def update
  end

  def destroy
    cart_item = cart.cart_items.find_by(id: params[:id])
    unless cart_item.present?
      render json: {status: { code: "400", message: "Invalid Item"}}, status: :bad_request and return
    end
    cart_item.destroy
  end
 
  def index
  end

  protected

  def validate_cart
    create_cart unless current_customer.cart.present?
  end

  def cart
    @cart ||= current_customer.cart
  end

  def create_cart
    current_customer.carts.create
  end

  def cart_item_params
    params.require(:cart_item).permit(:dish_id,:quantity)
  end

  def validate_item_params 
    unless dish.present?
      render json: { status: {code: "400", message: "Invalid Item"}},status: :bad_request and return
    end
  end

  def dish
    @dish ||= Dish.find_by(id: cart_item_params[:dish_id])
  end
end
