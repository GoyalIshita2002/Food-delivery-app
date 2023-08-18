class RestaurantOwner::CreateDish < ApplicationService
  def initialize(restaurant, params)
    @params = params
    @restaurant = restaurant
  end

  attr_reader :restaurant, :params

  def call
    dish = restaurant.dishes.create(params.except(:dish_type))
    unless dish.persisted?
      raise dish.errors.full_messages
    end
    dish_type = DishType.find_by(id: params[:dish_type])
    if params[:dish_type].present? && dish_type.present?
      dish.create_dish_category(dish_type: dish_type)
    end
    dish
  end
end