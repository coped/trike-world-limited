class PasswordResetsController < ApplicationController
  before_action :get_user,      only: [:edit, :update]
  before_action :valid_user,    only: [:edit, :update]
  before_action :expired_token, only: [:edit, :update]

  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user
      reset(@user)
      flash[:info] = "Email sent with password reset instructions."
      redirect_to login_path
    else
      flash.now[:warning] = "Email address not found."
      render 'new'
    end
  end

  def edit
  end

  def update
    if reset_params[:password].empty?
      @user.errors.add(:password, "can't be empty")
      render 'edit'
    elsif @user.update(reset_params)
      @user.forget_after_reset
      flash[:info] = "Password successfully updated."
      redirect_to login_path
    else
      render 'edit'
    end
  end

  private

    def reset_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def get_user
      @user = User.find_by(email: params[:email])
    end

    def valid_user
      if !(@user && @user.authenticates_with?(:reset_digest, params[:id]))
        flash[:warning] = "Something went wrong. Please try again."
        redirect_to login_path
      end
    end

    def expired_token
      if @user.password_reset_expired?
        flash[:warning] = "Password reset link expired. Please try again."
        redirect_to login_path
      end
    end
end
