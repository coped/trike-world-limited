class User < ApplicationRecord
    attr_accessor :remember_token

    before_save :downcase_email

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :name,     presence: true,
                         length: { maximum: 255 }
    validates :email,    presence: true,
                         format: { with: VALID_EMAIL_REGEX },
                         length: { maximum: 255 },
                         uniqueness: { case_sensitive: false }
    has_secure_password
    validates :password, presence: true,
                         length: { minimum: 6 },
                         allow_nil: true 

    has_many :posts

    def User.new_token
        SecureRandom.urlsafe_base64
    end

    def User.digest(string)
        BCrypt::Password.create(string)
    end

    def forget
        update_attribute(:remember_digest, nil)
    end

    def remember
        self.remember_token = User.new_token
        new_digest = User.digest(self.remember_token)
        update_attribute(:remember_digest, new_digest)
    end

    private
        
        def downcase_email
            self.email.downcase!
        end
end
