class Post < ApplicationRecord
    validates :content, format: { with: /\A[ぁ-んァ-ン一-龥]/}, length: { in: 4..9 }
    validates :two_content, format: { with: /\A[ぁ-んァ-ン一-龥]/}, length: { in: 4..10 }
    validates :three_content, format: { with: /\A[ぁ-んァ-ン一-龥]/}, length: { in: 4..9 }
    validates :four_content, format: { with: /\A[ぁ-んァ-ン一-龥]/}, length: { in: 4..10 }
    validates :five_content, format: { with: /\A[ぁ-んァ-ン一-龥]/}, length: { in: 4..10 }
    validates :hashtag, presence: true
    belongs_to :user
    has_many :favorites, dependent: :destroy
    has_many :likes, through: :favorites, source: :user, dependent: :destroy
    has_many :tag_posts, dependent: :destroy
    has_many :tags, through: :tag_posts, dependent: :destroy
    
    def favorite(user)
        favorites.find_or_create_by(user_id: user.id)
    end
    
    def unfavorite(user)
        favorites.find_by(user_id: user.id).destroy
    end
    
    def likes?(user)
        favorites.where(user_id: user.id).exists?
    end
    
    after_create do
        post = Post.find_by(id: self.id)
        tags = self.hashtag.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
        tags.uniq.map do |t|
            tag = Tag.find_or_create_by(hashname: t.downcase.delete('#'))
            post.tags << tag
        end
    end
end
