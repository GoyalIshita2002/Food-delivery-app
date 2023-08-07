class AdminUser < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  enum :role, [ :super_admin, :franchise_owner, :staff ]
  has_one_attached :avatar

  has_many :restaurant_users
  has_many :restaurants, through: :restaurant_users

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

  def jwt_payload
    # { 'foo' => 'bar' }
    super
  end
end
