class Document < ApplicationRecord
  belongs_to :documenter, polymorphic: true
  has_one_attached :front
  has_one_attached :back

  def front_url
    ActiveStorage::Current.set(host: Rails.application.credentials.fetch(:base_url)) do
      self.front.url
    end
  end

  def back_url
    ActiveStorage::Current.set(host: Rails.application.credentials.fetch(:base_url)) do
      self.back.url
    end
  end
end
 