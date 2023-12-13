class Restaurant < ApplicationRecord
  has_one :restaurant_user, dependent: :destroy
  has_one :admin_user, through: :restaurant_user

  has_one :service_location, class_name: 'ServiceLocation'

  has_one_attached :main_image
  has_many :restaurant_rating, dependent: :destroy
  has_many :restaurant_categories, dependent: :destroy
  has_many :categories, through: :restaurant_categories

  has_many :restaurant_cuisines, dependent: :destroy
  has_many :cuisines, through: :restaurant_cuisines

  has_many :open_hours, dependent: :destroy

  has_many :orders, dependent: :destroy

  has_many :restaurant_open_days, dependent: :destroy
  has_many :open_days, through: :restaurant_open_days

  has_one :avg_pricing, dependent: :destroy

  has_one :restaurant_address, dependent: :destroy

  has_many :restaurant_files

  has_many :dishes

  has_many :add_ons, class_name: 'DishAddOn', foreign_key: 'restaurant_id'

  has_one :restaurant_margin

  has_one :customer_margin

  validates_presence_of :name

  scope :opened, -> { where(open_for_orders: true, suspended: false) }

  def address 
    location = self.restaurant_address
    "#{location.street}, #{location.address}, #{location.zip_code}, #{location.state},#{location.state_code}"
  end

  def main_image_url
    ActiveStorage::Current.set(host: Rails.application.credentials.fetch(:base_url)) do
      self.main_image.url
    end
  end

  def coordinates
    location = self.restaurant_address
    [location.latitude, location.longitude ]
  end

  def working_hours
    self.open_hours.map(&:slot).join(' ')
  end



  
end  
