class CreateRestaurant < ApplicationService
  def initialize(params, restaurant_owner)
    @params = params[:restaurant]
    @owner = restaurant_owner
  end

  attr_reader :params, :owner

  def call
    restaurant = owner.create_restaurant(name: params[:name])
    map_categories(restaurant)  if params[:type].present?
    set_open_hours(restaurant)  if params[:open_time].present? || params[:close_time].present?
    set_restaurant_address(restaurant)  if params[:restaurant_address].present? && params[:restaurant_address][:address].present?
  end

  def map_categories(restaurant)
    category = Category.find_by(name: params[:type])
    restaurant.categories << category
  end

  def set_open_hours(restaurant)
    restaurant.open_hours.create(start_time: params[:open_time], end_time: params[:close_time])
  end

  def set_restaurant_address(restaurant)
    restaurant.create_restaurant_address(params[:restaurant_address])
  end
end