class Customer < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  has_one_attached :avatar
  has_one :customer_otp
  has_many :addresses, class_name: 'CustomerAddress', foreign_key: 'customer_id'

  def avatar_url
    ActiveStorage::Current.set(host: Rails.application.credentials.fetch(:base_url)) do
      self.avatar.url
    end
  end

  def jwt_payload
    super
  end

  def generate_jwt
    payload = { "jti"=> self.jti, "sub"=> self.id, "scp"=>"customer", "aud"=>nil, "iat"=>Time.now.to_i, "exp"=> 0 }
    JWT.encode(payload,  Rails.application.credentials.fetch(:secret_key_base))
  end

  def verification_otp
    create_customer_otp({otp: rand(1000..9999)}) unless self.customer_otp.present?
    customer_otp.otp
  end
end
