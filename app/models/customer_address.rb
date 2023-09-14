class CustomerAddress < ApplicationRecord
  validates :street, presence: true
  validates :address, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true

  geocoded_by :full_address
  after_validation :geocode

  def full_address
    [street, address, city, state, country].compact.join(', ')
  end
end
 