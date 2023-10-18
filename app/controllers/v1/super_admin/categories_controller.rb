class V1::SuperAdmin::CategoriesController < ApplicationController
  
  def index
    @dish_types=DishType.all
  end
end
