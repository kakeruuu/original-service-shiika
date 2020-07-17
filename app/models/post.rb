class Post < ApplicationRecord
    validates :content, format: { with: /\A[ぁ-んァ-ン一-龥]/ }
    belongs_to :user
end
