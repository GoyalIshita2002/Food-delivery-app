class V1::Customer::RestaurantsController < ApplicationController
  include Pagy::Backend

  def index
    if params[:search].present?
      search = params[:search].downcase
      dish_restaurant_ids = Dish.where('lower(name) LIKE ?', "%#{search}%").pluck(:restaurant_id).uniq
      @pagy, @restaurants = pagy(
        Restaurant.opened
                  .where('avg_rating::text LIKE :search OR id IN (:dish_restaurant_ids)',
                         search: "%#{search}%", dish_restaurant_ids: dish_restaurant_ids)
      )
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
