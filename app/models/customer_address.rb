class CustomerAddress < ApplicationRecord
  validates :street, presence: true
  validates :address, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true
  belongs_to :customer
  geocoded_by :full_address
  after_validation :geocode


  enum :address_type => { :home => 0, :office => 1}

  before_save :update_default

  def update_default
    if self.is_default
      CustomerAddress.where(customer_id: self.customer_id).update_all(is_default: false)
    end
  end

  def full_address
    [street, address, city, state, country].compact.join(', ')
  end
end
 