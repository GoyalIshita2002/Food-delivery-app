class OpenHour < ApplicationRecord
  belongs_to :restaurant
  has_many :split_hours
  
  def slot
    # "#{start_time.strftime('%H:%M')}-#{end_time.strftime('%H:%M')}"
  end
end
