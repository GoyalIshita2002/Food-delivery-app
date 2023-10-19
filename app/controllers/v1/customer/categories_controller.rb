class V1::Customer::CategoriesController < ApplicationController

  def index
    @categories = DishType.all
  end
end
 