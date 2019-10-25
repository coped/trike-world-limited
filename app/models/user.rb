class User < ApplicationRecord
    before_save :downcase_email

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :name,     presence: true
    validates :email,    presence: true,
                         format: { with: VALID_EMAIL_REGEX },
                         length: { maximum: 255 },
                         uniqueness: { case_sensitive: false }
    has_secure_password
    validates :password, presence: true,
                         length: { minimum: 6 },
                         allow_nil: true 

    has_many :posts

    private
        
        def downcase_email
            self.email.downcase!
        end
end
