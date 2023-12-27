class RestaurantOwner::UpdateAddOn < ApplicationService
  def initialize(add_on, params)
    @add_on = add_on
    @params = params
  end

  attr_accessor :params, :add_on

  def call
    add_on = ActiveRecord::Base.transaction do
      add_on = @add_on.update(add_on_params)
      @add_on.items.where.not(id: item_params.pluck(:id).compact).destroy_all
      item_params.each do |current_item|
        if current_item[:id].present? && @add_on.items.find_by(id: current_item[:id]).present? && current_item[:is_delete] == false
          @add_on.items.find_by(id: current_item[:id])&.update(current_item)
        else
          @add_on.items.create(current_item.except(:id))
        end
      end
      @add_on.reload
    end
  end

  def add_on_params
    params.except(:items)
  end

  def item_params
    params[:items]
  end
end