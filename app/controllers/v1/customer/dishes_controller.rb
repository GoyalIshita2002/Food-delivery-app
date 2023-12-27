class V1::Customer::DishesController < ApplicationController

  before_action :check_restaurant

  def index
    @dishes = current_restaurant.dishes.deleted_dish
   if params[:type]&.downcase == "popular"
    @dishes = @dishes.where(is_popular: true)
   else
    dish_type = DishType.find_by(title: params[:type])
    if dish_type.present?
      @dishes = @dishes.joins(:dish_category).where("dish_categories.dish_type_id": dish_type.id)
    end
   end
  end

  def grouped_dishes
    grouped_categories = DishCategory.joins(:dish).where("dishes.restaurant_id": current_restaurant.id)
                             .group("dish_categories.dish_type_id")
                             .pluck("dish_categories.dish_type_id","array_agg(dish_categories.dish_id)").to_h

    @data = Hash.new({"Popular": current_restaurant.dishes.popular })
    DishType.where(id: grouped_categories.keys).each do |dish_type|
      @data.merge!( "#{dish_type.title}" => Dish.where(id: grouped_categories[dish_type.id]))
    end
  end

  def check_restaurant
    unless current_restaurant.present?
      render json: { status: { code: "400", message: "Invalid/closed restaurant"}},status: :bad_request and return
    end
  end

  def current_restaurant
    @current_restaurant ||= Restaurant.opened.find_by(id: params[:restaurant_id]) 
  end

end
