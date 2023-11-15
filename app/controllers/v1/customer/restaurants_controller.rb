class V1::Customer::RestaurantsController < ApplicationController
  include Pagy::Backend

  def index
    if params[:search].present?
      search = params[:search].downcase
      restaurants_by_rating = Restaurant.where('avg_rating::text LIKE ?', "%#{search}%").opened
      dish_restaurant_ids = Dish.where('lower(name) LIKE ?', "%#{search}%").pluck(:restaurant_id).uniq
      restaurants_by_dish = Restaurant.where(id: dish_restaurant_ids)
      @pagy, @restaurants = pagy(restaurants_by_rating.or(restaurants_by_dish), items: params[:per_page]&.to_i)
    else
      @pagy, @restaurants = pagy(Restaurant.opened, items: params[:per_page]&.to_i)
    end
  end

  def show
    @restaurant = Restaurant.find_by(id: params[:id])
    unless @restaurant.present?
      render json: { code: { status: "404", error: "invalid restaurant ID"}}
    end
  end

end
