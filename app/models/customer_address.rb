class CustomerAddress < ApplicationRecord
  validates :street, presence: true
  validates :address, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true
end
