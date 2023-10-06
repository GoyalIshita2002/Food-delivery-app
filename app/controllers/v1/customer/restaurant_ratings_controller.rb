class V1::Customer::RestaurantRatingsController < ApplicationController
  before_action :check_restaurant ,only: [:add_rating]
  def add_rating
    add_rating =  current_customer.restaurant_rating.create(rating_params)
    avg = average_rating.to_f
    current_restaurant.update(avg_rating: avg)

    if add_rating.persisted?
      render json: { status: { code: "200", message: I18n.t('rating.success') } }, status: :ok
    else
      render json: { status: { code: "400", message: I18n.t('rating.failure'), errors: add_rating.errors.full_messages } }, status: :bad_request
    end
  end

  # def remove_rating
  #   remove_rating = RestaurantRating.where(restaurant_id: params[:restaurant_id], customer_id: current_customer.id)
  #   if remove_rating.present?
  #     remove_rating.destroy_all
  #    render json: { status: { code: "200", message: "Removed rating successfully"}}, staus: :ok and return
  #   else
  #    render json: { status: {code: "400", message: "Rating is not present"}}, status: :bad_request and return
  #   end
  # end

  # def update_rating
  #   update_rating = RestaurantRating.find_by(restaurant_id: params[:restaurant_id], customer_id: current_customer.id)
  #   if update_rating
  #     update_rating.update(res_rating: params[:res_rating])

  #     if update_rating.save
  #       render json: { status: { code: "200", message: "Rating updated successfully" } }, status: :ok
  #     else
  #       render json: { status: { code: "400", message: "Failed to update rating", errors: update_rating.errors.full_messages } }, status: :bad_request
  #     end
  #   else
  #     render json: { status: { code: "404", message: "Rating not found for the given restaurant and customer" } }, status: :not_found
  #   end
  # end




  protected

  def rating_params
    {
      restaurant_id: params[:restaurant_id], 
      rating: params[:rating] || 0
    }
  end

  def average_rating
    current_restaurant.restaurant_rating.average(:rating).round(2)
  end

  def current_restaurant
    @current_restaurant ||= Restaurant.find_by(id: params[:restaurant_id]) 
  end

  def check_restaurant
    unless current_restaurant.present? && !params[:restaurant_id].blank? && !params[:rating].blank?
      render json: {status: {code: "400" ,message:"Restauarnt is not present "}}
    end
  end
end
