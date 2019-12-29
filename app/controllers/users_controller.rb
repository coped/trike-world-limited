class UsersController < ApplicationController
  before_action :is_logged_in?,    only: [:edit, :edit_password, :update]
  before_action :is_current_user?, only: [:edit, :edit_password, :update]

  def show
    redirect_to about_path
  end

  def edit
  end

  def edit_password
    # render template: 'users/edit_password'
  end

  def update
    if @user.update(user_params)
      flash[:info] = "User settings updated"
      redirect_to edit_user_path(@user)
    else
      render 'users/edit'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :road_name, :password, :password_confirmation)
    end

    def is_current_user?
      @user = User.find_by(id: params[:id])
      redirect_to posts_path if current_user != @user
    end
end
