class Document < ApplicationRecord
  belongs_to :documenter, polymorphic: true
  has_one_attached :front
  has_one_attached :back

  ActiveStorage::Current.host = "http://localhost:3000"
end
 