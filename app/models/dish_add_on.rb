# frozen_string_literal: true

class DishAddOn < ApplicationRecord
  belongs_to :restaurant
  has_many :items, dependent: :destroy
  has_many :dish_items, dependent: :destroy
  scope :deleted_dish_add_on, -> { where(is_deleted: false) }
end
