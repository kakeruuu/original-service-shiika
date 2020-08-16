class Post < ApplicationRecord
    with_options length: { maximum: 10, message: '文字数が多すぎます' } do 
        with_options format: { with: /\A[ぁ-んァ-ン一-龥]/, message: 'に使用できない文字が入ってます。または文字が入っていません。'} do
            validates :content 
            validates :two_content
            validates :three_content
        end
        with_options format: { with: /\A[ぁ-んァ-ン一-龥]+|\A\z/, message: 'に使用できない文字が入ってます。' } do
            validates :four_content
            validates :five_content
        end
    end
    validates :hashtag, presence: { message: 'が入力されていません。'}
    
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
