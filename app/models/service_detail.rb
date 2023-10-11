class ServiceDetail < ApplicationRecord
  belongs_to :driver
  enum :vehicle, [ :Bike, :Bicycle ]
end
