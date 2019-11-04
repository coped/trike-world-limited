module PasswordResetsHelper
    def reset(user)
        user.create_reset_digest
        user.send_reset_email
    end
end
