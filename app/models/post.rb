class Post < ApplicationRecord
    has_one_attached :image
    
    validates :title,   presence: true,
                        length: { maximum: 255 }
    validates :body,    presence: true,
                        length: { maximum: 40_000 }
    validates :user_id, presence: true

    belongs_to :user

    def Post.index_by_most_recent
        self.includes(:user).order(created_at: :desc).all
    end
end
