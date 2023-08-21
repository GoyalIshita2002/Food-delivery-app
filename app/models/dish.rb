class Dish < ApplicationRecord
  belongs_to :restaurant
 
  has_one_attached :image
  has_one :dish_category, dependent: :destroy
  has_one :dish_type, through: :dish_category  

  def image_url
    ActiveStorage::Current.set(host: Rails.application.credentials.fetch(:base_url)) do
      self.image.url
    end
  end
end
