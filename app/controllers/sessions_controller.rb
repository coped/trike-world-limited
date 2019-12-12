class SessionsController < ApplicationController
  before_action :redirect_if_logged_in, only: [:new, :create]

  def new
  end

  def create
    @user = User.find_by(email: login_params[:email].downcase)
    if @user && @user.authenticate(login_params[:password])
      log_in(@user)
      login_params[:remember] == "1" ? remember(@user) : forget(@user)
      redirect_to(posts_path)
    else
      flash.now[:warning] = "Incorrect email / password combination."
      render "new"
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to posts_path
  end

  private

    def login_params
      params.require(:login).permit(:email, :password, :remember)
    end

    def redirect_if_logged_in
      redirect_to posts_path if current_user
    end
end
