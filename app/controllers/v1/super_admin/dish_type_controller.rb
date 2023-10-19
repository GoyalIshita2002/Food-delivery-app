class V1::SuperAdmin::DishTypeController < ApplicationController

  def create
    @dish_type=DishType.new(create_params)
    unless @dish_type.save
      render json: { status: {code: "400", messgae: "Failed to create a dishtype " }}, status: :bad_request and return
    end
  end
 
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

  def create_params
    params.permit(:title,:image)
  end
end
