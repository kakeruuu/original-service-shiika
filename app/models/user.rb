class User < ApplicationRecord
    before_save { self.email.downcase! }
    validates :name, presence: true, length: { maximum: 15 }
    validates :email, presence: true, length: { maximum: 255},
                      format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                      uniqueness: { case_sensitive: false }
    has_secure_password
    mount_uploader :image, ImagesUploader
    has_many :posts
    has_many :favorites
    has_many :likes, through: :favorites, source: :post
end
