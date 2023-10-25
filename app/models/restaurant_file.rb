class RestaurantFile < ApplicationRecord
  belongs_to :restaurant
  has_one_attached :file

  def file_url
    ActiveStorage::Current.set(host: Rails.application.credentials.fetch(:base_url)) do
      self.file.url
    end
  end
end
