class V1::Customer::FavouritesController < ApplicationController
  include Pagy::Backend

  before_action :check_restaurant , only: [:add_restaurant, :remove_restaurant]
  before_action :check_dish, only: [:add_dish, :remove_dish]

  def add_restaurant
    if current_customer.fav_restaurants.create!(restaurant_id: current_restaurant.id)
      render json: { status: { code: "200", message: "Added to favourites"}}, staus: :ok and return
    else
      render json: { status: {code: "400", messgae: "Failed to add restaurant to favourites" }}, status: :bad_request and return
    end
  end 

  def remove_restaurant
    fav_restaurant = current_customer.fav_restaurants.find_by(restaurant_id: current_restaurant.id)
    if fav_restaurant.destroy!
      render json: { status: { code: "200", message: "Removed Favourite successfully"}}, staus: :ok and return
    else
      render json: { status: {code: "400", error: fav_restaurant.errors.full_message }}, status: :bad_request and return
    end
  end

  def add_dish
    if current_customer.fav_dishes.create!(dish_id: current_dish.id)
      render json: { status: { code: "200", message: "Added to favourites"}}, staus: :ok and return
    else
      render json: { status: {code: "400", messgae: "Failed to add dish to favourites" }}, status: :bad_request and return
    end
  end

  def remove_dish
    fav_dish = current_customer.fav_dishes.find_by(dish_id: current_dish.id)
    if fav_dish.destroy!
      render json: { status: { code: "200", message: "Removed Favourite successfully"}}, staus: :ok and return
    else
      render json: { status: {code: "400", error: fav_dish.errors.full_message }}, status: :bad_request and return
    end
  end

  def list_restaurants 
    restaurant_ids = current_customer.fav_restaurants.pluck(:restaurant_id)
    @pagy, @restaurants = pagy(Restaurant.where(id: restaurant_ids), items: params[:per_page]&.to_i)
  end

  def list_dishes
    dish_ids = current_customer.fav_dishes.pluck(:dish_id)
    @pagy, @dishes = pagy(Dish.where(id: dish_ids), items: params[:per_page]&.to_i)
  end

  protected

  def check_restaurant
    unless current_restaurant.present?
      render json: { status: { code: "400", message: "invalid Restaurant"}}, status: :bad_request and return
    end
  end

  def check_dish
    unless current_dish.present?
      render json: { status: { code: "400", message: "invalid Dish"}}, status: :bad_request and return
    end
  end

  def current_restaurant
    @restaurant ||= Restaurant.find_by(id: params[:restaurant_id])
  end

  def current_dish
    @dish ||= Dish.find_by(id: params[:dish_id])
  end
end
