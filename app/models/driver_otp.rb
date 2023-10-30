class DriverOtp < ApplicationRecord
  belongs_to :driver
  validates :otp, length: { maximum: 4 }
end
