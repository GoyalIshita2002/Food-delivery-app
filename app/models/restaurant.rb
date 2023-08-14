class Restaurant < ApplicationRecord
  has_many :restaurant_users, dependent: :destroy
  has_many :admin_users, through: :restaurant_users

  has_one_attached :main_image

  has_many :restaurant_categories, dependent: :destroy
  has_many :categories, through: :restaurant_categories

  has_many :restaurant_cuisines, dependent: :destroy
  has_many :cuisines, through: :restaurant_cuisines

  has_many :open_hours, dependent: :destroy

  has_many :restaurant_open_days, dependent: :destroy
  has_many :open_days, through: :restaurant_open_days

  has_one :avg_pricing, dependent: :destroy

  has_one :restaurant_address, dependent: :destroy

  has_many :documents, as: :documenter

  has_many :dishes

  validates_presence_of :name

  def address
    location = self.restaurant_address
    "#{location.street}, #{location.address}, #{location.zip_code}, #{location.state}"
  end

  def coordinates
    location = self.restaurant_address
    [location.latitude, location.longitude ]
  end

  def working_hours
    self.open_hours.map(&:slot).join(' ')
  end
end  
