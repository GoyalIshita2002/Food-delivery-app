class OpenHour < ApplicationRecord
  belongs_to :restaurant

  def slot
    "#{start_time.strftime('%H:%M')}-#{end_time.strftime('%H:%M')}"
  end
end
