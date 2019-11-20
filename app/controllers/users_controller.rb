class UsersController < ApplicationController
  before_action :is_current_user?, only: [:edit, :edit_password]
  def show
    @user = User.find_by(id: params[:id])
  end

  def edit
  end

  def edit_password
  end

  def update
    # Update user attributes
  end

  private

    def user_params
      params.require(:user).permit(:name, :road_name)
    end

    def is_current_user?
      if current_user != User.find_by(id: params[:id])
        flash[:warning] = "You don't have permission to view that page."
        redirect_to posts_path
      end
    end
end
