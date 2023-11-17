class Customer < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self
  has_many :orders, dependent: :destroy

  has_many :devices
  has_one_attached :avatar
  has_one :customer_otp
  has_many :addresses, class_name: 'CustomerAddress', foreign_key: 'customer_id'
  has_many :carts
  has_many :fav_restaurants
  has_many :fav_dishes
  has_many :restaurant_rating
  def cart
    self.carts.find_by(status: :open) 
  end

  def avatar_url
    ActiveStorage::Current.set(host: Rails.application.credentials.fetch(:base_url)) do
      self.avatar.url
    end
  end

  def jwt_payload
    super
  end

  def generate_jwt
    payload = { "jti"=> self.jti, "sub"=> self.id, "scp"=>"customer", "aud"=>nil, "iat"=>Time.now.to_i, "exp"=> (Time.now + 1.years).to_i }
    JWT.encode(payload,  Rails.application.credentials.fetch(:secret_key_base))
  end

  def generate_reset_password_token
    self.reset_password_token = SecureRandom.urlsafe_base64
    self.save!
  end

  def verification_otp
    reload
    create_customer_otp({otp: rand(1000..9999)}) unless self.customer_otp.present?
    customer_otp.otp
  end

  def is_favourite_dish(dish_id)
    self.fav_dishes.where(dish_id: dish_id).present?
  end

  def is_favourite_restaurant(restaurant_id)
    self.fav_restaurants.where(restaurant_id: restaurant_id).present?
  end
end
