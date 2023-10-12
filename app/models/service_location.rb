class ServiceLocation < ApplicationRecord
  belongs_to :driver
  enum :vehicle, { bike: 0, bicycle: 1 }
end
