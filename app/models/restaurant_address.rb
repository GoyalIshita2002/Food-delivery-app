class RestaurantAddress < ApplicationRecord
  belongs_to :restaurant

  geocoded_by :address
  after_validation :geocode

  def address
    [street, address1, address2, city, state, state_code].compact.join(', ')
  end
end
 