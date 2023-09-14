class V1::Customer::RestaurantsController < ApplicationController
  include Pagy::Backend

  def index
    @pagy, @restaurants = pagy(Restaurant.all, items: params[:per_page]&.to_i)
  end

  def show
    @restaurant = Restaurant.find_by(id: params[:id])
    unless @restaurant.present?
      render json: { code: { status: "404", error: "invalid restaurant ID"}}
    end
  end
end
