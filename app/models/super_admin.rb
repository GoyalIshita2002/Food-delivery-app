class SuperAdmin < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable,
          :jwt_authenticatable, jwt_revocation_strategy: self

  def generate_jwt
    payload = { "jti"=> self.jti, "sub"=> self.id, "scp"=>"super_admin", "aud"=>nil, "iat"=>Time.now.to_i, "exp"=> (Time.now + 60.minutes).to_i }
    JWT.encode(payload,  Rails.application.credentials.fetch(:secret_key_base))
  end
end
 