class Customer::AddCartItem < ApplicationService

  def initialize(params, cart)
    @params = params
    @cart = cart
  end
  
  attr_reader :params, :cart

  def call
    restaurant_ids = if params[:dish_id].present?
      cart.cart_items.where(itemable_type: "Dish").map(&:itemable).pluck(:restaurant_id).uniq.compact
    elsif params[:add_on_item_id].present? 
      cart.cart_items.where(itemable_type: "Item").map(&:itemable).map(&:dish_add_on).pluck(:restaurant_id).uniq.compact
    end

    if restaurant_ids.present? && (restaurant_ids.length != 1 || restaurant_ids.last != current_item.restaurant_id)
      cart.cart_items.destroy_all
    end
    
    cart_item = cart.cart_items.find_by(itemable_id: current_item.id, itemable_type: current_item.class.to_s)
    if cart_item.present?
      cart_item.update!(item_params)
    else
      cart.cart_items.create!(item_params)
    end
  end

  def current_item
    if params[:dish_id].present?
      dish
    elsif params[:add_on_item_id].present?
      add_on_item
    end
  end

  def item_params
    quantity = (params[:quantity].to_i || 1)

    { itemable_id: current_item.id, itemable_type: current_item.class.to_s, quantity: quantity, ordered_price: (quantity * item_price), unit_price: item_price }
  end

  def dish
    @dish ||= Dish.find_by(id: params[:dish_id])
  end
  
  def add_on_item
    @add_on_item ||= Item.find_by(id: params[:add_on_item_id])
  end

  def item_price
    current_item.customer_price 
  end
end