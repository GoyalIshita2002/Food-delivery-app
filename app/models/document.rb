class Document < ApplicationRecord
  belongs_to :documenter, polymorphic: true
  has_one_attached :front
  has_one_attached :back

  ActiveStorage::Current.host = Rails.application.credentials.fetch(:base_url)
end
 