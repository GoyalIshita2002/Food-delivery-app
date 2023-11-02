# frozen_string_literal: true

class Item < ApplicationRecord
  belongs_to :dish_add_on
  has_many :dish_items

  def customer_price
    margin = dish_add_on.restaurant.customer_margin
    if margin.present? && margin.margin_percent.present?
      self.price + (margin.margin_percent.to_i * price)/100
    else
      self.price
    end
  end
end
