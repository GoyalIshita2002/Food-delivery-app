class RestaurantOwner::UpdateDish < ApplicationService
  def initialize(dish, params)
    @params = params
    @dish = dish
  end

  attr_reader :dish, :params

  def call
    updated_dish = dish.update(params.except(:dish_type))

    dish_type = DishType.find_by(id: params[:dish_type])
    if updated_dish.present? && params[:dish_type].present? && dish_type.present?
      dish.dish_category.delete if dish.dish_category.present?
      dish.create_dish_category(dish_type: dish_type)
    end

    if dish.errors.present?
      raise dish.errors.full_messages
    end

    dish.reload
  end
end