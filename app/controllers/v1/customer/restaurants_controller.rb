class V1::Customer::RestaurantsController < ApplicationController
  include Pagy::Backend

  def index
    if params[:search].present?
      search = params[:search].downcase
      dish_restaurant_ids = Dish.where('lower(name) LIKE ?', "%#{search}%").pluck(:restaurant_id).uniq
      @pagy, @restaurants = pagy(Restaurant.opened.where('id IN (:restaurant_ids) OR lower(name) LIKE :search', restaurant_ids:dish_restaurant_ids, search: "%#{search}%"), items: params[:per_page]&.to_i)
    else
      @pagy, @restaurants = pagy(Restaurant.opened, items: params[:per_page]&.to_i)
    end
  end
  

  def search
    criteria = {}
    criteria.merge!(avg_rating:search_params[:rating]) if search_params[:rating].present?
    @restaurants = if search_params[:dish_type].present?
      dish_type_ids = DishType.where("LOWER(title) IN (?)", search_params[:dish_type].map(&:downcase)).pluck(:id)
      Restaurant.opened.joins(dishes: :dish_category).where(criteria.merge!("dish_categories.dish_type_id": dish_type_ids)).distinct
    else
      Restaurant.opened.where(avg_rating: search_params[:rating]).distinct
    end
    @pagy, @restaurants = pagy(@restaurants, items: params[:per_page]&.to_i)
  end

  def show
    @restaurant = Restaurant.find_by(id: params[:id])
    unless @restaurant.present?
      render json: { code: { status: "404", error: "invalid restaurant ID"}}
    end
  end

end

private

def search_params
  params.permit(rating: [], dish_type: [])
end
