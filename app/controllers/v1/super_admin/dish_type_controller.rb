class V1::SuperAdmin::DishTypeController < ApplicationController

  def update
    unless dish_type.update(update_params)
      render json: { status: { code: "400", error: dish_type.errors.full_messages }}, status: :bad_request
    end
  end

  protected

  def check_dish_type
    unless dish_type.present?
      render json: { status: {code: "400", message:"Invalid dish_type id"}}, status: :bad_request and return
    end
  end

  def dish_type
    @dish_type ||= DishType.find_by(id: params[:id]) 
  end

  def update_params
    params.permit(:title,:image)
  end
end
