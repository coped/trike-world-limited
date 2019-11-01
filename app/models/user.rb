class User < ApplicationRecord
    attr_accessor :remember_token, :reset_token

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

    def authenticates_with?(digest_type, token)
        digest = self.send("#{digest_type}")
        return false if digest.nil?
        BCrypt::Password.new(digest).is_password?(token)
    end

    def remember
        self.remember_token = User.new_token
        new_digest = User.digest(self.remember_token)
        update_attribute(:remember_digest, new_digest)
    end

    def create_reset_digest
        self.reset_token = User.new_token
        update_attribute(:reset_digest, User.digest(reset_token))
        update_attribute(:reset_sent_at, Time.zone.now)
    end

    def send_reset_email
        UserMailer.password_reset(self).deliver_now!
    end

    def first_name
        self.name.split.first.capitalize
    end

    def password_reset_expired?
        2.hours.ago > self.reset_sent_at
    end

    private
        
        def downcase_email
            self.email.downcase!
        end
end
