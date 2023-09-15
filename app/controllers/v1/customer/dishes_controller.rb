class V1::Customer::DishesController < ApplicationController

  def index
    @dishes = if params[:restaurant_id].present? && current_restaurant.present?
                current_restaurant.dishes
              else
                Dish.all
              end
   if params[:type]&.downcase == "popular"
    @dishes = @dishes.where(is_popular: true)
   else
    dish_type = DishType.find_by(title: params[:type])
    if dish_type.present?
      @dishes = @dishes.joins(:dish_category).where("dish_categories.dish_type_id": dish_type.id)
    end
   end
  end

  def current_restaurant
    @current_restaurant ||= Restaurant.opened.find_by(id: params[:restaurant_id]) 
  end

end
