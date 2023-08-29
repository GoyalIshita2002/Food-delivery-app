# frozen_string_literal: true

class Item < ApplicationRecord
  belongs_to :dish_add_on
  has_many :dish_items
end
