class Dish < ApplicationRecord
  belongs_to :restaurant

  has_one_attached :image

  enum dish_type: [ "MainCourses", "Appetizer", "Pizza&Pasta" ]
  

  def image_url
    ActiveStorage::Current.host = Rails.application.credentials.fetch(:base_url)
    self.image.url
  end
end
