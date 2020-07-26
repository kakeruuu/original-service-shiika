class User < ApplicationRecord
    before_save { self.email.downcase! }
    validates :name, presence: true, length: { maximum: 15, message: 'の文字数は最大15文字です。' }
    validates :email, presence: true, length: { maximum: 255, message: 'が空欄です。' },
                      format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: 'の入力方法が間違っています。' },
                      uniqueness: { case_sensitive: false, message: 'はすでに存在します。' }
    validates :profile, length: { maximum: 250, message: 'の文字数は最大250文字です。' }
    has_secure_password
    mount_uploader :image, ImagesUploader
    has_many :posts
    has_many :favorites, dependent: :destroy
    has_many :likes, through: :favorites, source: :post, dependent: :destroy
end
