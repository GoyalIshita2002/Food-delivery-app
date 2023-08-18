class Dish < ApplicationRecord
  belongs_to :restaurant
 
  has_one_attached :image
  has_one :dish_category
  has_one :dish_type, through: :dish_category  

  def image_url
    ActiveStorage::Current.host = Rails.application.credentials.fetch(:base_url)
    self.image.url
  end
end
