class DishType < ApplicationRecord
  has_many :dish_category
  has_many :dishes, through: :dish_category

  has_one_attached :image

  def image_url
    ActiveStorage::Current.set(host: Rails.application.credentials.fetch(:base_url)) do
      self.image.url
    end
  end
end
