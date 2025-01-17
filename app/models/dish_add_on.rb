# frozen_string_literal: true

class DishAddOn < ApplicationRecord
  belongs_to :restaurant
  has_many :items, dependent: :destroy
  has_many :dish_items, dependent: :destroy
  default_scope -> { where(is_deleted: false) }
end
