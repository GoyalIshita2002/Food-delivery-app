class SuperAdmin::AddCartItem < ApplicationService

  def initialize(params, cart)
    @params = params
    @cart = cart
  end
  
  attr_reader :params, :cart

  def call
    cart_item = cart.cart_items.find_by(dish_id: dish.id)
    if cart_item.present?
      cart_item.update!(item_params)
    else
      cart.cart_items.create!(item_params)
    end
  end

  def item_params
    quantity = (params[:quantity].to_i || 1)
    { dish_id: dish.id, quantity: quantity, ordered_price: (quantity * item_price), unit_price: item_price }
  end

  def dish
    @dish ||= Dish.find_by(id: params[:dish_id])
  end 

  def item_price
    dish.customer_price 
  end
end