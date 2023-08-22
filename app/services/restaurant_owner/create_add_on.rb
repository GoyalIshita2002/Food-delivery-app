class RestaurantOwner::CreateAddOn < ApplicationService
  def initialize(restaurant, params)
    @restaurant = restaurant
    @params = params
  end

  attr_reader :restaurant, :params

  def call
    add_on = ActiveRecord::Base.transaction do
      add_on = restaurant.add_ons.create(add_on_params)
      add_on.items.create(item_params)
      add_on
    end
    add_on
  end

  def add_on_params
    params.except(:items)
  end

  def item_params
    params[:items]
  end
end