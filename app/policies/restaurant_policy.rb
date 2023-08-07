class RestaurantPolicy < ApplicationPolicy
  def initialize(user, restaurant)
    @user = user
    @restaurant = restaurant
  end

  attr_reader :user, :restaurant

  def create?
    user.super_admin? || user.franchise_owner?
  end

  def update?
    user.super_admin? || (user.franchise_owner? && user.restaurants.include?(restaurant))
  end

  def destroy?
    user.super_admin? || (user.franchise_owner? && user.restaurants.include?(restaurant))
  end
end