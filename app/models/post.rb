class Post < ApplicationRecord
    validates :content, format: { with: /\A[ぁ-んァ-ン一-龥]/ }
    belongs_to :user
    has_many :favorites
    has_many :likes, through: :favorites, source: :user
    
    def favorite(user)
        favorites.find_or_create_by(user_id: user.id)
    end
    
    def unfavorite(user)
        favorites.find_by(user_id: user.id).destroy
    end
    
    def likes?(user)
        favorites.where(user_id: user.id).exists?
    end
end
