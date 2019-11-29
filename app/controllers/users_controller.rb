class UsersController < ApplicationController
  before_action :get_user, only: [:show, :edit, :update]
  before_action :is_current_user?, only: [:edit, :edit_password]

  def show
    redirect_to about_path
  end

  def edit
    @user
  end

  def edit_password
  end

  def update
    # Update user attributes
  end

  private
    def get_user
      @user = User.find_by(id: params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :road_name)
    end

    def is_current_user?
      if current_user != @user
        flash[:warning] = "You don't have permission to view that page."
        redirect_to posts_path
      end
    end
end
