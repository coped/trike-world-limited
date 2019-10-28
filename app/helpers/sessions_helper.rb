module SessionsHelper
    def log_in(user)
        session[:user_id] = user.id
    end

    def log_out(user)
        user.forget
        session[:user_id]
    end
end
