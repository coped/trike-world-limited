class Post < ApplicationRecord
    validates :title,   presence: true,
                        length: { maximum: 255 }
    validates :body,    presence: true,
                        length: { maximum: 40_000 }
    validates :user_id, presence: true

    belongs_to :user
end
