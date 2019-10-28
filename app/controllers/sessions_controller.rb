class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: login_params[:email])
    if @user && @user.authenticated?(login_params[:password])
      log_in(@user)
      flash[:success] = "Successfully logged in."
      redirect_to(posts_path)
    else
      flash.now[:warning] = "Incorrect email / password combination."
      render 'new'
    end
  end

  def destroy
    log_out
  end

  private

    def login_params
      params.require(:login).permit(:email, :password)
    end
end
