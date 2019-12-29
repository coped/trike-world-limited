class ApplicationController < ActionController::Base
    include SessionsHelper
    include PasswordResetsHelper

    private

        def is_logged_in?
            redirect_to posts_path if !current_user
        end
end
