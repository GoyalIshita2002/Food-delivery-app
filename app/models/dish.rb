# frozen_string_literal: true

class Dish < ApplicationRecord
  belongs_to :restaurant

  has_one_attached :image
  has_one :dish_category, dependent: :destroy
  has_one :dish_type, through: :dish_category
  has_many :dish_items, dependent: :destroy
  has_many :dish_add_ons, through: :dish_items
  has_many :items, through: :dish_items

  scope :popular, -> { where(is_popular: true) }
  default_scope -> { where(is_deleted: false) }

  def image_url
    ActiveStorage::Current.set(host: Rails.application.credentials.fetch(:base_url)) do
      image.url
    end
  end

  def customer_price
    margin = restaurant.customer_margin
    if margin.present? && margin.margin_percent.present?
      self.price + (margin.margin_percent.to_i * price)/100
    else
      self.price
    end
  end
end
