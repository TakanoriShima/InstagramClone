class User < ApplicationRecord
  validates :name,  presence: true, length: { in: 3..32 }
  validates :email, presence: true, length: { in: 5..256 }, uniqueness: true,
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_save { email.downcase! }
  has_secure_password
  validates :password, presence: true, length: { in: 6..32 }
  has_many :pictures, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_pictures, through: :favorites, source: :picture
  mount_uploader :image, ImageUploader
end
