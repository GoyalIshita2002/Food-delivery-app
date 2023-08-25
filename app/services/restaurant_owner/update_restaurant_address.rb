class RestaurantOwner::UpdateRestaurantAddress < ApplicationService
  def initialize(restaurant, params)
    @params = params
    @restaurant = restaurant
  end

  attr_reader :restaurant, :params

  def call
    unless restaurant.restaurant_address.update!(params)
      raise restaurant.errors.full_messages
    end
  end
end