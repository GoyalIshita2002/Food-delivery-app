class Driver < ApplicationRecord
  validates :phone, presence: true, uniqueness: true
  has_one_attached :profile_image
  has_one :driver_otp

  before_create :generate_jti
  before_commit :generate_otp
  has_many :documents, as: :documenter
  delegate :otp, to: :driver_otp

  def generate_jti
    unless jti.present? 
      jti = SecureRandom.uuid
      while Driver.exists?(jti: jti)
        jti = SecureRandom.uuid
      end
      self.jti = jti
    end
  end 

  def generate_otp
    self.create_driver_otp(otp: rand(1000..9999))
  end

  def verification_otp
    create_delivery_otp({otp: rand(1000..9999)}) unless self.delivery_otp.present?
    delivery_otp.otp
  end

  def generate_jwt
    payload = { "jti"=> self.jti, "sub"=> self.id, "scp"=>"driver", "aud"=>nil, "iat"=>Time.now.to_i, "exp"=> (Time.now + 1.years).to_i }
    JWT.encode(payload,  Rails.application.credentials.fetch(:secret_key_base))
  end
end
