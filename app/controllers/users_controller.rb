class UsersController < ApplicationController
  before_action :is_logged_in?,    only: [:edit, :edit_password, :update]
  before_action :is_current_user?, only: [:edit, :edit_password, :update]

  def show
    redirect_to about_path
  end

  def edit
  end

  def update
    if @user.update(user_params)
      @user.avatar.attach(user_params[:avatar]) if user_params[:avatar]
      flash[:info] = "Account settings updated"
      redirect_to edit_user_path(@user)
    else
      render 'users/edit'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :road_name, :password, :password_confirmation, :avatar)
    end

    def is_current_user?
      @user = User.find_by(id: params[:id])
      redirect_to posts_path if current_user != @user
    end
end
