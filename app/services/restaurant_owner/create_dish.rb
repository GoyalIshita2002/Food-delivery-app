# frozen_string_literal: true

class RestaurantOwner::CreateDish < ApplicationService
  def initialize(restaurant, params)
    @params = params
    @restaurant = restaurant
  end

  attr_reader :restaurant, :params

  def call
    ActiveRecord::Base.transaction do
      dish = restaurant.dishes.create(params.except(:dish_type, :add_ons))
      raise dish.errors.full_messages unless dish.persisted?

      dish_type = DishType.find_by(id: params[:dish_type])
      dish.create_dish_category(dish_type:) if params[:dish_type].present? && dish_type.present?
      assign_addons(dish) if params[:add_ons].present?
      dish.reload
    end
  end

  def assign_addons(dish)
    params[:add_ons].each do |add_on|
      dish_add_on = DishAddOn.find_by(id: add_on[:id])
      dish_items = []
      if dish_add_on.present?
        dish_add_on.items.where(id: add_on[:sub_item_ids]).each do |item|
          dish_items.push({ dish_add_on_id: dish_add_on.id, item_id: item.id, dish_id: dish.id })
        end
      end
      dish.dish_items.create(dish_items) unless dish_items.empty?
    end
  end
end
