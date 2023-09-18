class AdminUser < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  enum :role, [ :super_admin, :franchise_owner, :staff ]
  has_one_attached :avatar

  has_one :restaurant_user
  has_one :restaurant, through: :restaurant_user

  validate :acceptable_image

  def acceptable_image
    return unless avatar.attached?
  
    unless avatar.blob.byte_size <= 1.megabyte
      errors.add(:avatar, "is too big")
    end
  
    acceptable_types = ["image/jpeg", "image/png"]
    unless acceptable_types.include?(avatar.content_type)
      errors.add(:avatar, "must be a JPEG or PNG")
    end
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
    payload = { "jti"=> self.jti, "sub"=> self.id, "scp"=>"admin_user", "aud"=>nil, "iat"=>Time.now.to_i, "exp"=> (Time.now + 60.minutes).to_i }
    JWT.encode(payload,  Rails.application.credentials.fetch(:secret_key_base))
  end
end
