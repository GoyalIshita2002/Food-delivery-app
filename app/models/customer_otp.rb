class CustomerOtp < ApplicationRecord
  belongs_to :customer
  validates :otp, length: { maximum: 4 }
end
